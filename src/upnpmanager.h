#ifndef UPNPMANAGER_H
#define UPNPMANAGER_H

#include <QTimer>
#include <QUdpSocket>

class UpnpManager : public QUdpSocket
{
public:
    UpnpManager();
    void sendDiscoveryMessage();
    void stopSendingDiscoveryMessage();
    void handleMessage(QString message);

private:
    QTimer     m_broadcastTimer;
    QByteArray m_requestMessage = {
        "M-SEARCH * HTTP/1.1\r\nHOST: 239.255.255.250:1900\r\nMAN: "
        "\"ssdp:discover\"\r\nMX: 1\r\nST: "
        "urn:remote:service:dial:1\r\nUSER-AGENT:"
        "DemonPresentationBoard\r\n\r\n"};

    QString m_respondMessage = {
        "NOTIFY * HTTP/1.1\r\nHOST: 239.255.255.250:1900\r\n"
        "Location:%1\r\nUSER-AGENT:DemonPresentationBoard\r\n\r\n"};
};

#endif // UPNPMANAGER_H
