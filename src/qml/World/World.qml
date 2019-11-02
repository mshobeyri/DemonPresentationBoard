import QtQuick 2.12
import "../Elements"

Item{
    anchors.fill: parent
    property var currentElement: undefined
    property alias frame: iframe
    Rectangle {
        id: iframe
        antialiasing: true
        color: "#9da8b3"
        x: 20
        y: 20
        width: iwin.width - 40
        height: iwin.height - 40

        PinchArea{
            anchors.fill: parent
            pinch.target: iframe
            pinch.minimumRotation: -360
            pinch.maximumRotation: 360
            pinch.minimumScale: 0.1
            pinch.maximumScale: 10
            pinch.dragAxis: Pinch.XAndYAxis
            property real zRestore: 0
            onSmartZoom: {
                if (pinch.scale > 0) {
                    iframe.rotation = 0;
                    iframe.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                    iframe.x = flick.contentX + (flick.width - iframe.width) / 2
                    iframe.y = flick.contentY + (flick.height - iframe.height) / 2
                    zRestore = iframe.z
                    iframe.z = ++root.highestZ;
                } else {
                    iframe.rotation = pinch.previousAngle
                    iframe.scale = pinch.previousScale
                    iframe.x = pinch.previousCenter.x - iframe.width / 2
                    iframe.y = pinch.previousCenter.y - iframe.height / 2
                    iframe.z = zRestore
                    --root.highestZ
                }
            }
        }

        MouseArea{
            id: iframeMouseArea

            anchors.fill: parent
            drag.axis: Drag.XAndYAxis
            drag.target: iframe
            preventStealing: false
            hoverEnabled: true
            onClicked: {
                if(isidePanel.insertCandidateComponent!==""){
                    var component = Qt.createComponent(isidePanel.insertCandidateComponent)
                    if(component.status === Component.Ready)
                        component.createObject(iframe , {x:mouseX,y:mouseY})
                }

                currentElement = undefined
                isidePanel.container.elements.deselectAll()
            }
            focus: true
            Keys.onPressed: {
                if (event.key === Qt.Key_Control) {
                    event.accepted = true;
                }
            }
            onWheel: {
                if (wheel.modifiers & Qt.ControlModifier) {
                    iframe.rotation += wheel.angleDelta.y / 120 * 5;
                    if (Math.abs(iframe.rotation) < 4)
                        iframe.rotation = 0;
                } else {
                    iframe.rotation += wheel.angleDelta.x / 120;
                    if (Math.abs(iframe.rotation) < 0.6)
                        iframe.rotation = 0;
                    var scaleBefore = iframe.scale;
                    iframe.scale += iframe.scale * wheel.angleDelta.y / 120 / 10;
                }
            }
        }

        ElementRectangle{

        }
    }
}
