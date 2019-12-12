import QtQuick 2.12
import QtQuick.Controls 2.5
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    fixAspectRatio: true

    property string color: "primary"
    property string fontFamilyName: ifontAwsome.name
    property string icon: "info-circle"
    property bool bold: false
    property var json: {
        "type":Element.icon,
        "common": icontainer.commonData,
        "color": icontainer.color.toString(),
        "fontFamilyName": icontainer.fontFamilyName,
        "bold": icontainer.bold,
        "icon": icontainer.icon
    }
    function fromJson(json){
        color = json.color
        fontFamilyName = json.fontFamilyName
        icon = json.icon
        bold = json.bold
    }

    component:  Component {
        Label {
            color: ithemeGallery.themeColor(icontainer.color)
            antialiasing: true
            font.family: icontainer.bold?ifontAwsome.name:ifontAwsomereg.name
            font.bold: icontainer.bold
            text: icontainer.icon
            width: height
            anchors.centerIn: parent
            font.pixelSize: height/1.1
        }
    }
}
