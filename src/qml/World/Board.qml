import QtQuick 2.12

Item {
    id: iboard

    antialiasing: true
    x: (iroot.width - width) / 2
    y: (iroot.height - height) / 2
    width: 1920
    height: 1080
    scale: Math.min(iroot.width / width,iroot.height/height)*0.95

    property alias elementContainer: ielementContainer
    property alias background: ibackground

    PinchArea{
        anchors.fill: parent
        pinch.target: iboard
        pinch.minimumRotation: -360
        pinch.maximumRotation: 360
        pinch.minimumScale: 0.1
        pinch.maximumScale: 10
        pinch.dragAxis: Pinch.XAndYAxis
        property real zRestore: 0
        onSmartZoom: {
            if (pinch.scale > 0) {
                iboard.rotation = 0;
                iboard.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                iboard.x = flick.contentX + (flick.width - iboard.width) / 2
                iboard.y = flick.contentY + (flick.height - iboard.height) / 2
                zRestore = iboard.z
                iboard.z = ++root.highestZ;
            } else {
                iboard.rotation = pinch.previousAngle
                iboard.scale = pinch.previousScale
                iboard.x = pinch.previousCenter.x - iboard.width / 2
                iboard.y = pinch.previousCenter.y - iboard.height / 2
                iboard.z = zRestore
                --root.highestZ
            }
        }
    }

    MouseArea {
        id: iframeMouseArea

        anchors.fill: parent
        drag.axis: Drag.XAndYAxis
        drag.target: iboard
        preventStealing: false
        hoverEnabled: true
        onClicked: {
            if(isidePanel.insertCandidateComponent!==""){
                createElement(isidePanel.insertCandidateComponent,
                             {x:mouseX,y:mouseY,rotation: - iboard.rotation})

                ifileManager.fileChanged()
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
                iboard.rotation += wheel.angleDelta.y / 120 * 5;
                if (Math.abs(iboard.rotation) < 4)
                    iboard.rotation = 0;
            } else {
                iboard.rotation += wheel.angleDelta.x / 120;
                if (Math.abs(iboard.rotation) < 0.6)
                    iboard.rotation = 0;
                var scaleBefore = iboard.scale;
                iboard.scale += iboard.scale * wheel.angleDelta.y / 120 / 10;
            }
        }
    }

    Background{
        id: ibackground
    }

    Item{
        id: ielementContainer

        anchors.fill: parent
    }
}
