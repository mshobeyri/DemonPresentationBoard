import QtQuick 2.12
import "../Elements/ElementHelper.js" as Element
import "../qmlHelper.js" as Qmlhelper

Item {
    id: iboard

    antialiasing: true
    width: 1920
    height: 1080

    property alias elementContainer: ielementContainer
    property alias background: ibackground
    property alias scaleTransform: itransform
    property bool animeEnable: true
    function sceneCenter(){
        return mapFromItem(iworld,iworld.width/2,iworld.height/2)
    }
    function moveCenter(){
        iboard.x = (iworld.width - iboard.width*itransform.xScale)/2
        iboard.y = (iworld.height - iboard.height*itransform.yScale)/2
    }
    function boardGeometry(){
        return {
            "x": iboard.x,
            "y": iboard.y,
            "scale": iboard.scaleTransform.xScale,
        }
    }

    transform: Scale {
        id: itransform

        Behavior on xScale {enabled: animeEnable; PropertyAnimation { duration: animationDuration;  easing.type: Easing.InOutCubic } }
        Behavior on yScale {enabled: animeEnable; PropertyAnimation { duration: animationDuration;  easing.type: Easing.InOutCubic } }
    }

    Behavior on x { PropertyAnimation { duration: animationDuration; easing.type: Easing.InOutCubic } }
    Behavior on y { PropertyAnimation { duration: animationDuration; easing.type: Easing.InOutCubic } }

    MouseArea {
        id: iframeMouseArea

        anchors.fill: parent
        propagateComposedEvents: true
        drag.axis: Drag.XAndYAxis
        drag.target: iboard
        onClicked: {
            if(isidePanel.insertCandidateComponent!==""){
                createElement(isidePanel.insertCandidateComponent,
                              {x:mouseX,y:mouseY})

                ifileManager.fileChanged()
            }
            currentElement = undefined
            isidePanel.container.elements.deselectAll()
        }

        property double factor: 2.0

        onWheel: {
            var zoomFactor = wheel.angleDelta.y > 0 ? factor : 1 / factor
            var realX = wheel.x * itransform.xScale
            var realY = wheel.y * itransform.yScale
            iboard.x += (1 - zoomFactor) * realX
            iboard.y += (1 - zoomFactor) * realY
            itransform.xScale *= zoomFactor
            itransform.yScale *= zoomFactor
        }
    }

    Background{
        id: ibackground
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
