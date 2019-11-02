import QtQuick 2.12

ElementBase{
    id: icontainer
    property color color: "blue"
    property color borderColor: "#fff"
    property real borderWidth: 1
    component:  Component {
        Rectangle {
            color: icontainer.color
            border.width: icontainer.borderWidth
            border.color: icontainer.borderColor
            antialiasing: true
        }
    }
}
