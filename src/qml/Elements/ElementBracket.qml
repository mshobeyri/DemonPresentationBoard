import QtQuick 2.12

ElementBase{
    id: icontainer
    property int rectWidth: 10
    property color color: "blue"
    property color backgroundColor: "white"
    component:  Component {
        Rectangle {
            color: icontainer.backgroundColor
            antialiasing: true
            Rectangle{
                width:rectWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                }
            }
            Rectangle{
                width:rectWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                }
            }

            Rectangle{
                width: 2*rectWidth
                height: rectWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    left: parent.left
                }
            }
            Rectangle{
                width: 2*rectWidth
                height: rectWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    right: parent.right
                }
            }
            Rectangle{
                width: 2*rectWidth
                height: rectWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    bottom: parent.bottom
                    left: parent.left
                }
            }
            Rectangle{
                width: 2*rectWidth
                height: rectWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    bottom: parent.bottom
                    right: parent.right
                }
            }
        }
    }
}
