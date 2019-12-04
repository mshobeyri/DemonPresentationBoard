import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property string color: "accent"
    property string rightMarker: "triangle"
    property string leftMarker: ""

    onRightMarkerChanged: {
        json.rightMarker = rightMarker
        ifileManager.fileChanged()
    }
    onLeftMarkerChanged: {
        json.leftMarker = leftMarker
        ifileManager.fileChanged()
    }

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
    onCreated: {
        h = w / 4
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
                color: ithemeGallery.themeColor(icontainer.color)
                antialiasing: true
            }
            Text{
                id: irightMarker

                text: icontainer.rightMarker
                rotation: 90
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                color: ithemeGallery.themeColor(icontainer.color)
                font.pixelSize: parent.height / 1.3
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
                color: ithemeGallery.themeColor(icontainer.color)
                font.pixelSize: parent.height/ 1.3
                font.bold: true
                font.family: ifontAwsome.name
                antialiasing: true
                width: visible?paintedWidth:0
                height: visible?paintedHeight:0
            }
        }
    }
}
