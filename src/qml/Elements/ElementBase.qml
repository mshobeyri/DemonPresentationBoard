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
    property bool deleted: false
    property int baseWidth: 100
    property int baseHeight: 100
    property alias w: isizeHandle.x
    property alias h: isizeHandle.y
    property alias r: ibaseElement.rotation
    property alias selectDragMouseArea: iselectDragMouseArea
    property alias component: iloader.sourceComponent
    property alias componentSrc: iloader.source
    property alias loader: iloader
    property bool fixAspectRatio: false
    property int aspectRatio: 1
    property real handleSize: 16
    readonly property bool selected: currentElement === iroot
    property bool editMode: false
    property bool locked: false
    property var elementJson : iroot.json
    signal doubleClicked;
    signal created
    signal positionChanged
    signal sizeChanged
    signal angleChanged
    property var commonData: {
        "x": iroot.x,
        "y": iroot.y,
        "z": iroot.z,
        "w": iroot.w,
        "h": iroot.h,
        "r": ibaseElement.rotation,
        "l": iroot.locked,
        "v": iroot.visible,
    }

    function deleteIt(){
        iworld.currentElement = undefined
        visible = false
        deleted = true
        ifileManager.fileChanged()
    }

    function fromJsonBase(json){
        iroot.x = json.x
        iroot.y = json.y
        iroot.z = json.z
        iroot.w = json.w
        if(!fixAspectRatio)
            iroot.h = json.h
        ibaseElement.rotation = json.r
        iroot.locked = json.l
        iroot.visible = json.v
    }

    onCreated: {
        baseWidth *= iworld.handlesScale
        baseHeight *= iworld.handlesScale
    }


    Item {
        id: imain;

        width: isizeHandle.x+handleSize/2;
        height: isizeHandle.y+handleSize/2;
        anchors.centerIn: parent;

        property real centerX : (width / 2);
        property real centerY : (height / 2);


        Item{
            id: ibaseElement

            transformOrigin: Item.Center;
            antialiasing: true;
            anchors.fill: parent;

            Loader{
                id: iloader
                anchors.fill: parent
            }
            DropShadow{
                source: iloader.item
                anchors.fill: ibaseElement
                horizontalOffset: 0
                verticalOffset: 0
                radius: 8.0
                samples: 17
                color: "#80000000"
                visible: iworld.handlesScale > 0.5
            }
            MouseArea{
                id: iselectDragMouseArea

                anchors.fill: parent
                propagateComposedEvents: true
                onDoubleClicked: iroot.doubleClicked()
                drag.target: iroot
                drag.axis: Drag.XAndYAxis
                cursorShape: {}
                property bool moved: false

                onClicked: {
                    if(currentElement == iroot)
                        currentElement = undefined
                    else
                        currentElement = iroot
                }
                onPressed: {
                    if(locked && iworld.selectLockedElement){
                        iworld.selectLockedElement = false
                        mouse.accepted = true
                        return
                    }
                    iworld.selectLockedElement = false

                    if(editMode || locked || lockAllElements)
                        mouse.accepted = false
                }

                onPositionChanged: moved = true
                onReleased: {
                    if(moved)
                    {
                        ifileManager.fileChanged()
                        iroot.positionChanged()
                        moved = false
                    }
                }
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
                scale: iworld.handlesScale
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
                        Material.foreground: "white"
                    }
                }

                MouseArea{
                    anchors.fill: parent;
                    onReleased: {
                        ifileManager.fileChanged()
                        angleChanged()
                    }
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

                x: (baseWidth) - width/2
                y: fixAspectRatio? x * aspectRatio : baseHeight - width/2
                width: handleSize
                height: width
                opacity: selected? 1 : 0
                visible: opacity!==0
                scale: iworld.handlesScale
                Behavior on opacity {
                    NumberAnimation{duration: 200}
                }
                Pane{
                    anchors.fill: parent
                    Material.elevation: 6
                }
                MouseArea{
                    anchors.fill: parent
                    drag.target: isizeHandle
                    drag.axis: fixAspectRatio?Drag.XAxis:Drag.XAndYAxis
                    drag.minimumX: Math.max(iworld.handlesScale * handleSize,10)
                    drag.minimumY: drag.minimumX
                    onReleased: {
                        ifileManager.fileChanged()
                        sizeChanged()
                    }
                }
                Rectangle  {
                    radius: 3
                    color:"midnightblue"
                    antialiasing: true
                    anchors.fill: parent
                    anchors.margins: -1

                    Label{
                        font.pixelSize: parent.height/3*2
                        font.family: ifontAwsome.name
                        text: "arrows-alt-h"
                        Material.foreground: "white"
                        rotation: 45
                        anchors {
                            centerIn: parent
                            verticalCenterOffset: 1
                            horizontalCenterOffset: 1
                        }
                    }
                }
            }
        }
    }
}
