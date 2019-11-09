import QtQuick 2.12
import QtWebSockets 1.1
import QtQml 2.12

Item{
    property WebSocket connection: null

    function handleMessage(message){
        var messageJson = JSON.parse(message)
        switch (message.cmd){
        case "next": itimeline.goNext()
            break;
        case "prev": itimeline.goPrev()
            break;
        case "goto": itimeline.goTo(messageJson.frame)
            break;
        case "laser": iworld.fakeLaser.
            pointTo(messageJson.x,messageJson.y)
            break;
        }
    }

    function frameChanged(){
        if(connection!==null){
            connection.sendTextMessage(
                        JSON.stringify(
                            itimeline.currentFrameData()))
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
                webSocket.sendTextMessage(message);
            });
        }
    }
}
