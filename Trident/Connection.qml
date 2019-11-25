import QtWebSockets 1.1
import QtQuick 2.12

Item{
    id: iroot

    property alias url: isocket.url
    property bool isConnected: isocket.status === WebSocket.Open
    property var urls: []
    property int urlsIndex: 0

    function fakeLaser(x,y){
        var m ={
            "cmd": "laser",
            "x":x,
            "y":y
        }
        isocket.sendTextMessage(JSON.stringify(m))
    }
    function setLaserSettings(){
        var m ={
            "cmd": "laserSettings",
            "color":ilaserSetting.color,
            "size":ilaserSetting.size
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
    function goTo(frameIndex){
        var m = {
            "cmd": "goto",
            "frameIndex":frameIndex
        }
        isocket.sendTextMessage(JSON.stringify(m))
    }

    function getFrames(){
        var m ={
            "cmd": "frames",
        }
        isocket.sendTextMessage(JSON.stringify(m))
    }

    WebSocket{
        id: isocket

        active: true

        onBinaryMessageReceived: {
            imageData = message
        }
        onTextMessageReceived: {
            var mesageJson = JSON.parse(message)
            switch(mesageJson.cmd){
            case "frames":
                var ci
                ci = framesCombo.currentIndex
                framesCombo.model = mesageJson.frames
                framesCombo.currentIndex = ci
                break
            case "frameData":
                notes = mesageJson.frameData.data.notes
                framesCombo.currentIndex = mesageJson.frameData.index
            }
        }
        onStatusChanged: {
            if(status===WebSocket.Open){
                ireconnecTimer.stop()
                getFrames()
                setLaserSettings()
            }else{
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

    Connections{
        target: upnp
        onNewUrlListRecieved:{
            upnp.stopDiscovery()
            urls = JSON.parse(urlList)
            urlsIndex = 0
            iupnpsocket.url = ""
            iupnpsocket.url = urls[0]
        }
    }
    WebSocket{
        id: iupnpsocket

        active: true

        onStatusChanged: {
            if(status===WebSocket.Open){
                isocket.url = iupnpsocket.url
                var str = iupnpsocket.url.toString()
                str = str.replace("ws://","");
                str = str.split(":");
                iconnectionSetting.ip = str[0]
                iconnectionSetting.port = str[1]

            }else if(status===WebSocket.Error){
                if(urlsIndex <urls.length-1){
                    urlsIndex++
                    iupnpsocket.url = urls[urlsIndex]
                }
            }
        }
    }
}
