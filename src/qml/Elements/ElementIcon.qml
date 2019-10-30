import QtQuick 2.12
import QtQuick.Controls 2.5

ElementBase{
    id: icontainer

    fixAspectRatio: true

    property color color: "blue"
    property string fontFamilyName: ifontAwsome.name
    property string icon: "info-circle"
    component:  Component {
        Label {
            color: icontainer.color
            antialiasing: true
            font.family: icontainer.fontFamilyName
            text: icontainer.icon
            width: height
            anchors.centerIn: parent
            font.pixelSize: height / 1.4
        }
    }
}
