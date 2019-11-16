#include "upnpmanager.h"
#include <QNetworkDatagram>
#include <QNetworkInterface>

const QHostAddress upnpAddress = QHostAddress{"239.255.255.250"};
const quint16      upnpPort    = 1900;

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


QString
urls() {
    QStringList urls;
    auto        interfaces = activeInterfaces();
    for (auto& interface : interfaces) {
        for (auto address : interface.allAddresses()) {
            if (address.protocol() != QAbstractSocket::IPv4Protocol)
                continue;
            auto url =
                address.toString().prepend("ws://").append(":").append("1422");
            if (!urls.contains(url)) {
                urls.push_back(url);
            }
        }
    }
    return urls.join(',').prepend("[").append(']');
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
            m_requestMessage, m_requestMessage.size(), upnpAddress, upnpPort);
    });
    m_broadcastTimer.start(1000);
}

void
UpnpManager::stopSendingDiscoveryMessage() {
    m_broadcastTimer.stop();
}

void
UpnpManager::handleMessage(QString message) {
    if (message.endsWith("USER-AGENT:DemonPresentationBoard\r\n\r\n") &&
        message.startsWith("M-SEARCH")) {
        QByteArray message = m_respondMessage.arg(urls()).toUtf8();
        this->writeDatagram(message, upnpAddress, upnpPort);
    } else if (
        message.endsWith("USER-AGENT:DemonPresentationBoard\r\n\r\n") &&
        message.startsWith("NOTIFY")) {
        auto begin = message.indexOf("Location:");
        qDebug() << message.mid(begin, message.indexOf("\r\n", begin));
    }
}
