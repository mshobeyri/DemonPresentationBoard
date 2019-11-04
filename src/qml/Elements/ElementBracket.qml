import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property color color: "blue"
    property color backgroundColor: "transparent"
    property int braceWidth: 10
    property var json: {
        "type":Element.bracket,
        "common": icontainer.commonData,
        "color": icontainer.color,
        "backgroundColor": icontainer.backgroundColor,
        "braceWidth": icontainer.braceWidth
    }

    component:  Component {
        Rectangle {
            color: icontainer.backgroundColor
            antialiasing: true
            Rectangle{
                width:braceWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                }
            }
            Rectangle{
                width:braceWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    bottom: parent.bottom
                    right: parent.right
                }
            }

            Rectangle{
                width: 2*braceWidth
                height: braceWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    left: parent.left
                }
            }
            Rectangle{
                width: 2*braceWidth
                height: braceWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    top: parent.top
                    right: parent.right
                }
            }
            Rectangle{
                width: 2*braceWidth
                height: braceWidth
                color: icontainer.color
                antialiasing: true
                anchors{
                    bottom: parent.bottom
                    left: parent.left
                }
            }
            Rectangle{
                width: 2*braceWidth
                height: braceWidth
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
