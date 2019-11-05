import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property color color: "#333333"
    property string rightMarker: "triangle"
    property string leftMarker: ""

    property var json: {
        "type": Element.arrow,
        "common": icontainer.commonData,
        "color": icontainer.color.toString(),
        "rightMarker": icontainer.rightMarker,
        "leftMarker":  icontainer.leftMarker
    }
    function fromJson(json){
        color = json.color
        rightMarker = json.rightMarker
        leftMarker = json.leftMarker
    }
    component:  Component {
        Item {
            antialiasing: true
            Rectangle{
                anchors{
                    right: parent.right
                    left: parent.left
                    rightMargin: irightMarker.height*0.8
                    leftMargin: ileftMarker.height*0.8
                    verticalCenter: parent.verticalCenter
                }
                height: parent.height / 2
                color: icontainer.color
                antialiasing: true
            }
            Text{
                id: irightMarker

                text: icontainer.rightMarker
                rotation: 90
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: icontainer.color
                font.pixelSize: parent.height
                font.bold: true
                font.family: ifontAwsome.name
                antialiasing: true
                width: visible?paintedWidth:0
                height: visible?paintedHeight:0
            }
            Text{
                id: ileftMarker

                text: icontainer.leftMarker
                rotation: -90
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                color: icontainer.color
                font.pixelSize: parent.height
                font.bold: true
                font.family: ifontAwsome.name
                antialiasing: true
                width: visible?paintedWidth:0
                height: visible?paintedHeight:0
            }
        }
    }
}
