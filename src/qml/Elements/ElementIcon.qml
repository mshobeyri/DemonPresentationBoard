import QtQuick 2.12
import QtQuick.Controls 2.5

ElementBase{
    id: icontainer

    fixAspectRatio: true

    property color color: "#002c4f"
    property string fontFamilyName: ifontAwsome.name
    property string icon: "info-circle"
    property bool bold: false
    component:  Component {
        Label {
            color: icontainer.color
            antialiasing: true
            font.family: icontainer.fontFamilyName
            font.bold: icontainer.bold
            text: icontainer.icon
            width: height
            anchors.centerIn: parent
            font.pixelSize: height / 1.4
        }
    }
}
