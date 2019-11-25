import QtQuick 2.12
import QtWebSockets 1.1
import QtQml 2.12

Item{
    property WebSocket connection: null
    property alias url: isocketServer.url

    function sendImage(image){
        image.saveToFile(fileio.tempFolder()+"/sc.png");
        connection.sendBinaryMessage(
                    fileio.getImageData(fileio.tempFolder()+"/sc.png"))
    }

    function sendMessage(message){
        if(connection!==null)
            connection.sendTextMessage(message)
    }
    function sendFrameDataToTrident(){
        var message = {
            "cmd": "frameData",
            "frameData":itimeline.currentFrameData()
        }
        sendMessage(JSON.stringify(message))
    }

    function sendFramesNameToTrident(){
        var message = {
            "cmd":"frames",
            "frames": itimeline.framesName()
        }
        sendMessage(JSON.stringify(message))
    }

    function handleMessage(message){
        var messageJson = JSON.parse(message)
        switch (messageJson.cmd){
        case "next": itimeline.goNext()
            break;
        case "prev": itimeline.goPrev()
            break;
        case "goto": itimeline.goTo(messageJson.frameIndex)
            break;
        case "laser":
            iworld.fakeLaser.
            pointTo(messageJson.x,messageJson.y)
            break;
        case "laserSettings":
            iworld.fakeLaser.setLaserSetting(
                        messageJson.color,messageJson.size)
        break
        case "frames":
            sendFramesNameToTrident()
            break;
        }
    }

    WebSocketServer {
        id: isocketServer

        listen: true
        port: 54321
        onClientConnected: {
            connection = webSocket
            webSocket.onTextMessageReceived.connect(function(message) {
                handleMessage(message)
            });
        }
    }
}
