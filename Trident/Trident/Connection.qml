import QtWebSockets 1.1
import QtQuick 2.12

Item{
    function fakeLaser(x,y){
        var m ={
            "cmd": "laser",
            "x":x,
            "y":y
        }
        isocket.sendTextMessage(JSON.stringify(m))
    }
    function goNext(){
        var m ={
            "cmd": "next",
        }

        isocket.sendTextMessage(JSON.stringify(m))
    }
    function goPrev(){
        var m ={
            "cmd": "prev",
        }

        isocket.sendTextMessage(JSON.stringify(m))
    }

    WebSocket{
        id: isocket

        url: "ws://127.0.0.1:19574"
        active: true

        onBinaryMessageReceived: {
            imageData = message
        }
        onTextMessageReceived: {
            var mesageJson = JSON.parse(message)
            notes = mesageJson.notes

        }

        onStatusChanged: {
            if(status===WebSocket.Open)
                ireconnecTimer.stop()
            else{
                ireconnecTimer.start()
            }
        }
    }
    Timer{
        id: ireconnecTimer
        interval: 1000
        repeat: true
        onTriggered: {
            isocket.active = false
            isocket.active = true
        }
    }
}
