import QtQuick 2.12
import Qt.labs.platform 1.1


Item{
    id: iroot

    x: -iboard.x * velocity / 100
    y: -iboard.y * velocity / 100
    width: parent.width
    height: parent.height

    property string tempName: ""
    property int velocity: 0
    property string color: "#30080d"
    property string source: "qrc:/res/res/backgrounds/pattern-10.svg"
    property int quality: 20
    property int tileH : 5;
    property int tileV : 5;
    property int type: 0 // color image pattern

    onTileHChanged: iimage.updateSize()
    onTileVChanged: iimage.updateSize()
    onQualityChanged: iimage.updateSize()

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
    }
    FileDialog{
        id: isourceSelector

        nameFilters: ["Image files (*.jpg *.jpeg *.png *.svg *.gif)", "All files (*.*)"]
        onAccepted: {
            iroot.tempName = fileio.copyToTempFolder(currentFile)
            iroot.source = fileio.tempFolderFileUrl(tempName)
            ifileManager.fileChanged()
        }
    }

    Image{
        id: iimage

        anchors.fill: parent
        fillMode: type ===1 ? Image.PreserveAspectFit : Image.Tile
        source: parent.source
        antialiasing: true
        smooth: true
        visible: type > 0
        property int imageW
        property int imageH

        function updateSize(){
            if(type == 1){
                sourceSize = Qt.size(quality*iroot.width/20,quality*iroot.height/20)
            }else if(type === 2){
                sourceSize = Qt.size(iroot.width/tileH,iroot.height/tileV)
            }
        }

        onStatusChanged: {
            if(status === Image.Ready)updateSize()
        }
    }
}

