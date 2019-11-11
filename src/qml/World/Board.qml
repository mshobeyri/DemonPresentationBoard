import QtQuick 2.12
import "../Elements/ElementHelper.js" as Element
import "../qmlHelper.js" as Qmlhelper

Item {
    id: iboard

    antialiasing: true
    width: 20000
    height: 20000

    /* Move "camera" to center */
    x: -500
    y: -1000
    Component.onCompleted: {
        x = (iworld.width - width)/2
        y = (iworld.height - height)/2
    }
//    scale: Math.min(iroot.width / width,iroot.height/height)*0.95

    property alias elementContainer: ielementContainer
    property alias background: ibackground
    readonly property real transitionDuration: 200 // ms

    function sceneCenter(){
        return mapFromItem(iworld,iworld.width/2,iworld.height/2)
    }
    transform: Scale {
        id: transform

        Behavior on xScale { PropertyAnimation { duration: transitionDuration;  easing.type: Easing.InOutCubic } }
        Behavior on yScale { PropertyAnimation { duration: transitionDuration;  easing.type: Easing.InOutCubic } }
    }

    Behavior on x { PropertyAnimation { duration: transitionDuration; easing.type: Easing.InOutCubic } }
    Behavior on y { PropertyAnimation { duration: transitionDuration; easing.type: Easing.InOutCubic } }

//    PinchArea{
//        anchors.fill: parent
//        pinch.target: iboard
//        pinch.minimumRotation: -360
//        pinch.maximumRotation: 360
//        pinch.minimumScale: 0.1
//        pinch.maximumScale: 10
//        pinch.dragAxis: Pinch.XAndYAxis
//        property real zRestore: 0
//        onSmartZoom: {
//            if (pinch.scale > 0) {
//                iboard.rotation = 0;
//                iboard.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
//                iboard.x = flick.contentX + (flick.width - iboard.width) / 2
//                iboard.y = flick.contentY + (flick.height - iboard.height) / 2
//                zRestore = iboard.z
//                iboard.z = ++root.highestZ;
//            } else {
//                iboard.rotation = pinch.previousAngle
//                iboard.scale = pinch.previousScale
//                iboard.x = pinch.previousCenter.x - iboard.width / 2
//                iboard.y = pinch.previousCenter.y - iboard.height / 2
//                iboard.z = zRestore
//                --root.highestZ
//            }
//        }
//    }

    MouseArea {
        id: iframeMouseArea

        anchors.fill: parent
        propagateComposedEvents: true
        drag.axis: Drag.XAndYAxis
        drag.target: iboard
        onClicked: {
            if(isidePanel.insertCandidateComponent!==""){
                createElement(isidePanel.insertCandidateComponent,
                              {x:mouseX,y:mouseY,rotation: - iboard.rotation})

                ifileManager.fileChanged()
            }
            currentElement = undefined
            isidePanel.container.elements.deselectAll()
        }

//        focus: true
//        Keys.onPressed: {
//            if (event.key === Qt.Key_Control) {
//                event.accepted = true;
//            }
//        }
        property double factor: 2.0

        onWheel: {
            if (wheel.modifiers & Qt.ControlModifier) {
                iboard.rotation += wheel.angleDelta.y / 120 * 5;
                if (Math.abs(iboard.rotation) < 4)
                    iboard.rotation = 0;
            } else {
//                iboard.rotation += wheel.angleDelta.x / 120;
//                if (Math.abs(iboard.rotation) < 0.6)
//                    iboard.rotation = 0;
//                var scaleBefore = iboard.scale;
//                iboard.scale += iboard.scale * wheel.angleDelta.y / 120 / 10;
                var zoomFactor = wheel.angleDelta.y > 0 ? factor : 1 / factor
                var realX = wheel.x * transform.xScale
                var realY = wheel.y * transform.yScale
                iboard.x += (1 - zoomFactor) * realX
                iboard.y += (1 - zoomFactor) * realY
                transform.xScale *= zoomFactor
                transform.yScale *= zoomFactor
            }

        }
    }

    Background{
        id: ibackground
        rotation: 45
    }

    Item{
        id: ielementContainer

        anchors.fill: parent
    }
    DropArea{
        anchors.fill: parent
        onEntered: {
            drag.accepted = Qmlhelper.isImage(drag.urls[0]) ||
                    Qmlhelper.isMedia(drag.urls[0])
        }
        onDropped: {
            for(var i = 0; i< drop.urls.length;i++){
                if(Qmlhelper.isImage(drop.urls[i]))
                    iworld.createElement(Element.image,{source:drop.urls[i],x:drag.x,y:drag.y})
                if(Qmlhelper.isMedia(drop.urls[i]))
                    iworld.createElement(Element.media,{source:drop.urls[i],x:drag.x,y:drag.y})
            }
        }
    }
}
