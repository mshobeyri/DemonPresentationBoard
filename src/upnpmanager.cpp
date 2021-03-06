#include "upnpmanager.h"
#include <QNetworkDatagram>
#include <QNetworkInterface>
#include <QTcpSocket>

const QHostAddress upnpAddress = QHostAddress{"239.255.255.250"};
const quint16      upnpPort    = 1900;
static quint16      selectedPort=0;

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

    m_broadcastTimer.setSingleShot(false);
    connect(&m_broadcastTimer, &QTimer::timeout, [this]() {
        this->writeDatagram(
                    m_requestMessage, m_requestMessage.size(), upnpAddress, upnpPort);
    });
    bind(QHostAddress::AnyIPv4, upnpPort, QAbstractSocket::ShareAddress);

}

QString UpnpManager::urls()
{
    QStringList urls;
    auto        interfaces = activeInterfaces();
    for (auto& interface : interfaces) {
        for (auto address : interface.addressEntries()) {
            if (address.ip().protocol() != QAbstractSocket::IPv4Protocol)
                continue;
            auto url =
                    address.ip().toString().prepend("ws://").append(":")
                    .append(QString::number(selectedPort));
            if (!urls.contains(url)) {
                urls.push_back(url);
            }
        }
    }
    return urls.join("\",\"").prepend("[\"").append("\"]");
}

int UpnpManager::freePort()
{
    QTcpSocket socket;
    for(quint16 i=54321;i < 60000;i++){
        if(socket.bind(QHostAddress::Any,i)){
            socket.close();
            selectedPort = i;
            return i;
        }
    }
    return -1;
}

void
UpnpManager::startDiscovery() {
    m_broadcastTimer.start(1000);
}

void
UpnpManager::stopDiscovery() {
    m_broadcastTimer.stop();
}

void UpnpManager::writeRespond()
{
    QByteArray message = m_respondMessage.arg(urls()).toUtf8();
    for (auto interface:activeInterfaces()) {
        setMulticastInterface(interface);
        this->writeDatagram(message, upnpAddress, upnpPort);
    }
}

void
UpnpManager::handleMessage(QString message) {
    if (handleSearch &&
            message.endsWith("USER-AGENT:DemonPresentationBoard\r\n\r\n") &&
            message.startsWith("M-SEARCH")) {
        this->writeRespond();
    } else if (
               handleNotify &&
               message.endsWith("USER-AGENT:DemonPresentationBoard\r\n\r\n") &&
               message.startsWith("NOTIFY")) {
        QString beginStr = "Location:";
        QString endStr   = "]";
        auto    begin    = message.indexOf(beginStr) + beginStr.length();
        newUrlListRecieved(
                    message.mid(begin, message.indexOf(endStr) - begin + 1));
    }
}
