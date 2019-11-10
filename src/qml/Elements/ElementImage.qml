import QtQuick 2.12
import Qt.labs.platform 1.1
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer
    baseWidth: 130
    baseHeight: 90
    property string source: "qrc:/res/res/image.svg"
    property bool isAnimated: icontainer.source.indexOf(".gif")===icontainer.source.length-4
    property bool isVector: icontainer.source.indexOf(".svg")===icontainer.source.length-4
    property var json: {
        "type":Element.image,
        "common": icontainer.commonData,
        "source": icontainer.source
    }

    function fromJson(json){
        source = json.source
    }

    onCreated: {
        if(icontainer.source == "qrc:/res/res/image.svg")
            isourceSelector.open()
    }

    FileDialog{
        id: isourceSelector
        nameFilters: ["Image files (*.jpg *.png *.svg *.gif)", "All files (*.*)"]
        onAccepted: {
            icontainer.source = currentFile
        }
        onRejected: icontainer.deleteIt()
    }

    component:  Component {
        Item{
            Image{
                anchors.fill: parent
                source: visible?icontainer.source:""
                visible: icontainer.isVector
                antialiasing: true
                sourceSize: Qt.size(width/iworld.handlesScale,height/iworld.handlesScale)
            }

            Image {
                anchors.fill: parent
                source: visible?icontainer.source:""
                visible: !icontainer.isVector && !icontainer.isAnimated
                antialiasing: true
            }

            AnimatedImage{
                anchors.fill: parent
                source:visible?icontainer.source:""
                visible: icontainer.isAnimated
                antialiasing: true
            }
        }
    }
}
