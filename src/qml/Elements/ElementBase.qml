import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtGraphicalEffects 1.0

Item{
    id: iroot;
    x: 120
    y: 120
    width: 0;
    height: 0;
    property bool fixAspectRatio: false
    property real handleSize: 16
    property bool selected: currentElement === iroot
    property alias component:iloader.sourceComponent
    property bool editMode: false
    signal doubleClicked;
    Item {
        id: imain;

        width: isizeHandle.x+handleSize/2;
        height: isizeHandle.y+handleSize/2;
        anchors.centerIn: parent;

        property real centerX : (width / 2);
        property real centerY : (height / 2);

        Item{
            id: ibaseElement;
            transformOrigin: Item.Center;
            antialiasing: true;
            anchors.fill: parent;

            Loader{
                id: iloader
                anchors.fill: parent
            }

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    if(currentElement == undefined)
                        currentElement = iroot
                    else
                        currentElement = undefined
                }
                onDoubleClicked: iroot.doubleClicked()
                drag.target: iroot
                drag.axis: Drag.XAndYAxis
                enabled: !editMode
            }

            Pane{
                id: irotationHandle
                x: 100 - handleSize/2
                y: 100 - handleSize/2
                width: handleSize;
                height: width;
                Material.elevation: 6
                opacity: selected? 1 : 0
                visible: opacity!==0
                padding: 0
                anchors {
                    horizontalCenter: parent.right
                    verticalCenter: parent.verticalCenter
                }
                Behavior on opacity {
                    NumberAnimation{duration: 200}
                }
                Rectangle  {
                    anchors.fill: parent
                    anchors.margins: -1
                    radius: 3
                    color:"#2e7811"
                    antialiasing: true
                    Label{
                        font.pixelSize: parent.height/3*2
                        font.family: ifontAwsome.name
                        text: "sync-alt"
                        anchors.centerIn: parent
                    }
                }

                MouseArea{
                    anchors.fill: parent;
                    onPositionChanged:  {
                        var point =  mapToItem (imain, mouse.x, mouse.y);
                        var diffX = (point.x - imain.centerX);
                        var diffY = -1 * (point.y - imain.centerY);
                        var rad = Math.atan (diffY / diffX);
                        var deg = (rad * 180 / Math.PI);
                        if (diffX > 0 && diffY > 0) {
                            ibaseElement.rotation =  - Math.abs (deg);
                        }
                        else if (diffX > 0 && diffY < 0) {
                            ibaseElement.rotation =   Math.abs (deg);
                        }
                        else if (diffX < 0 && diffY > 0) {
                            ibaseElement.rotation = 180 + Math.abs (deg);
                        }
                        else if (diffX < 0 && diffY < 0) {
                            ibaseElement.rotation = 180 - Math.abs (deg);
                        }
                    }
                }
            }
            Item{
                id: isizeHandle

                x: 100 - width/2
                y: fixAspectRatio? x :100 - width/2
                width: handleSize
                height: width
                opacity: selected? 1 : 0
                visible: opacity!==0
                Behavior on opacity {
                    NumberAnimation{duration: 200}
                }
                Pane{
                    anchors.fill: parent
                    Material.elevation: 6
                }

                Rectangle  {
                    id: ihandleRect

                    radius: 3
                    color:"midnightblue"
                    antialiasing: true
                    z:1

                    anchors.fill: parent
                    anchors.margins: -1

                    Label{
                        font.pixelSize: parent.height/3*2
                        font.family: ifontAwsome.name
                        text: "arrows-alt-h"
                        rotation: 45
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: 1
                            horizontalCenterOffset: 1
                        }
                    }
                }
                MouseArea{
                    anchors.fill: parent
                    drag.target: isizeHandle
                    drag.axis: fixAspectRatio?Drag.XAxis:Drag.XAndYAxis
                    drag.minimumX: 30
                    drag.minimumY: drag.minimumX
                }
            }
        }
    }
}
