import QtQuick 2.12

ElementBase{
    id: icontainer
    property color color: "#333333"
    property color borderColor: "#141452"
    property real borderWidth: 10
    component:  Component {
        Rectangle {
            color: icontainer.color
            border.width: icontainer.borderWidth
            border.color: icontainer.borderColor
            antialiasing: true
        }
    }
}
