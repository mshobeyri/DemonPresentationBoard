import QtQuick 2.12
import "../Elements/ElementHelper.js" as Element
import "../qmlHelper.js" as Qmlhelper

Item {
    id: iboard

    antialiasing: true
    width: 1920*4
    height: 1080*4

    property alias elementContainer: ielementContainer
    property alias background: ibackground
    property bool animeEnable: true
    property alias xScale: itransform.xScale
    property alias yScale: itransform.yScale

    function sceneCenter(){
        return mapFromItem(iworld,iworld.width/2,iworld.height/2)
    }
    function boardGeometry(){
        return {
            "x": iboard.x,
            "y": iboard.y,
            "scale": iboard.xScale,
        }
    }
    function toJson(){
        var json ={
            "type":ibackground.type,
            "tempName":"",
            "color": ibackground.color,
            "tileH": ibackground.tileH,
            "tileV": ibackground.tileV,
            "velocity": ibackground.velocity,
            "quality": ibackground.quality
        }
        if(ibackground.type!==0){
            json.tempName =ibackground.tempName
        }
        return json
    }
    function fromJson(json){
        ibackground.type = json.type
        ibackground.tempName = json.tempName
        ibackground.color = json.color
        ibackground.tileH = json.tileH
        ibackground.tileV = json.tileV
        ibackground.velocity = json.velocity
        ibackground.quality = json.quality
        if(json.tempName!=="")
            ibackground.source = fileio.tempFolderFileUrl(json.tempName)
    }

    function binaries(){
        if(ibackground.type===0)
            return ""
        return background.tempName
    }

    transform: Scale {
        id: itransform

        Behavior on xScale {enabled: animeEnable; PropertyAnimation { duration: animationDuration;  easing.type: Easing.InOutSine } }
        Behavior on yScale {enabled: animeEnable; PropertyAnimation { duration: animationDuration;  easing.type: Easing.InOutSine } }
    }

    Behavior on x { PropertyAnimation { duration: animationDuration; easing.type: Easing.InOutSine } }
    Behavior on y { PropertyAnimation { duration: animationDuration; easing.type: Easing.InOutSine } }

    Shortcut{
        sequence: "Space"
        onActivated: {
            iframeMouseArea.forceActiveFocus()
            spaceIsDown = true
        }
        autoRepeat: false
    }
    MouseArea {
        id: iframeMouseArea

        focus: true
        anchors.fill: parent
        propagateComposedEvents: true
        drag.axis: Drag.XAndYAxis
        drag.target: iboard
        cursorShape: containsMouse && isidePanel.insertCandidateComponent===""?
                         Qt.ClosedHandCursor:
                         spaceIsDown? Qt.OpenHandCursor:
                                      Qt.ArrowCursor

        Keys.onSpacePressed: {
            if (event.isAutoRepeat)
                return ;
            spaceIsDown = true
        }
        Keys.onReleased: {
            if (event.isAutoRepeat)
                return;
            if (event.key === Qt.Key_Space && spaceIsDown)
                spaceIsDown = false
        }

        onPressed: forceActiveFocus()
        onClicked: {
            worldOptions.forceActiveFocus()
            if(isidePanel.insertCandidateComponent!==""){
                createElement(isidePanel.insertCandidateComponent,
                              {x:mouseX,y:mouseY})
                if(isidePanel.insertCandidateComponent!==Element.image &&
                        isidePanel.insertCandidateComponent!==Element.media)
                    ifileManager.fileChanged()
            }
            currentElement = undefined
            isidePanel.container.elements.deselectAll()
        }

        onWheel: {
            if(wheel.angleDelta.y === 0)
                return
            var factor = wheel.modifiers & Qt.ControlModifier? 1.01:1.5
            var zoomFactor = wheel.angleDelta.y > 0 ? factor : 1 / factor
            var realX = wheel.x * xScale
            var realY = wheel.y * yScale
            iboard.x += (1 - zoomFactor) * realX
            iboard.y += (1 - zoomFactor) * realY
            xScale *= zoomFactor
            yScale *= zoomFactor
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
            drag.accepted = drag.urls[0]!==undefined &&
                    (Qmlhelper.isImage(drag.urls[0]) ||
                     Qmlhelper.isMedia(drag.urls[0]))
        }
        onDropped: {
            for(var i = 0; i< drop.urls.length;i++){
                if(Qmlhelper.isImage(drop.urls[i]))
                    var element = iworld.createElement(Element.image,{source:drop.urls[i],x:drag.x,y:drag.y})
                if(Qmlhelper.isMedia(drop.urls[i]))
                    element = iworld.createElement(Element.media,{source:drop.urls[i],x:drag.x,y:drag.y})
                element.handleFile(drop.urls[i])
            }
        }
    }
}
