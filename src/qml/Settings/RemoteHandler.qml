import QtQuick 2.12
import QtWebSockets 1.1
import QtQml 2.12

Item{
    property WebSocket connection: null

    function sendImage(image){
        image.saveToFile(fileio.tempFolder()+"/sc.png");
        connection.sendBinaryMessage(
                    fileio.getImageData(fileio.tempFolder()+"/sc.png"))
    }
    function sendMessage(message){
        if(connection!==null)
            connection.sendTextMessage(message)
    }

    function handleMessage(message){
        var messageJson = JSON.parse(message)
        switch (messageJson.cmd){
        case "next": itimeline.goNext()
            break;
        case "prev": itimeline.goPrev()
            break;
        case "goto": itimeline.goTo(messageJson.frame)
            break;
        case "laser":
            iworld.fakeLaser.
            pointTo(messageJson.x,messageJson.y)
            break;
        }
    }

    WebSocketServer {
        listen: true
        port: 19574
        Component.onCompleted: console.log(url)
        onClientConnected: {
            connection = webSocket
            webSocket.onTextMessageReceived.connect(function(message) {
                handleMessage(message)
            });
        }
    }
}
