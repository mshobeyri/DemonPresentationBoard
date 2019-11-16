#include "upnpmanager.h"
#include <QNetworkDatagram>
#include <QNetworkInterface>

const QHostAddress upnpAddress = QHostAddress{"239.255.255.250"};
const quint16 upnpPort = 1900;

QList<QNetworkInterface>
activeInterfaces() {
    QList<QNetworkInterface> actives;

#if defined(_MSC_VER) // visual studio
    const int
#else
    constexpr const int
#endif
        KRequirement = QNetworkInterface::IsUp | QNetworkInterface::IsRunning;

    auto interfaces = QNetworkInterface::allInterfaces();
    for (const auto& iface : interfaces) {
        auto flags = iface.flags();
        if (flags & QNetworkInterface::IsLoopBack)
            continue;
        if (!(flags & KRequirement) || !iface.isValid())
            continue;
        actives.append(iface);
    }
    return actives;
}

UpnpManager::UpnpManager() {
    connect(
        this,
        &QUdpSocket::stateChanged,
        [this](QAbstractSocket::SocketState state) {
            if (state != QAbstractSocket::BoundState)
                return;
            for (auto interface : activeInterfaces()) {
                joinMulticastGroup(upnpAddress, interface);
            }
            connect(this, &QUdpSocket::readyRead, this, [this]() {
                while (hasPendingDatagrams()) {
                    QNetworkDatagram datagram = receiveDatagram();
                    this->handleMessage(datagram.data());
                }
            });
        });

    bind(QHostAddress::AnyIPv4, upnpPort, QAbstractSocket::ShareAddress);
}

void
UpnpManager::sendDiscoveryMessage() {
    m_broadcastTimer.setSingleShot(false);
    connect(&m_broadcastTimer, &QTimer::timeout, [this]() {
        this->writeDatagram(
            m_message, m_message.size(), upnpAddress, upnpPort);
    });
    m_broadcastTimer.start(1000);
}

void
UpnpManager::stopSendingDiscoveryMessage() {
    m_broadcastTimer.stop();
}

void
UpnpManager::handleMessage(QString message) {
    qDebug() << message;
}
