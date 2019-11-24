import QtQuick 2.12
import Qt.labs.platform 1.1


Item{
    id: iroot

    x: -iboard.x * velocity / 100
    y: -iboard.y * velocity / 100
    width: parent.width
    height: parent.height
    property int velocity: 0
//    property string color: "#500a99"
property string color: "white"
    property string source: "qrc:/res/res/backgrounds/pattern-10.svg"
    property int quality: 20
    property int aboundance : 20
    property int type: 0 // color image pattern

    function openImageSelector(){
        isourceSelector.open()
    }

    onSourceChanged: {
        iimage.sourceSize = undefined
        iimage.updateSize()
    }
    onTypeChanged: iimage.updateSize()

    Rectangle{
        anchors.fill: parent
        antialiasing: true
        color: parent.color
        border.width: 2
        border.color: "black"
    }
    FileDialog{
        id: isourceSelector

        nameFilters: ["Image files (*.jpg *.png *.svg *.gif)", "All files (*.*)"]
        onAccepted: iroot.source = currentFile
    }

    Image{
        id: iimage

        anchors.fill: parent
        fillMode: type ===1 ? Image.PreserveAspectFit : Image.Tile
        source: parent.source
        antialiasing: true
        smooth: true
        visible: type > 0
        property int imageWidth: 1
        property int imageHeight: 1
        function updateSize(){
            if(type == 1){
                sourceSize = Qt.size(quality*iroot.width/20,quality*iroot.width/20)
            }else if(type === 2){
                imageWidth = sourceSize.width
                imageHeight = sourceSize.height
                sourceSize = Qt.size(iimage.width / imageWidth ,
                                     iimage.height/imageHeight)
            }
        }

        onStatusChanged: {
            if(status === Image.Ready)updateSize()
        }
    }
}

