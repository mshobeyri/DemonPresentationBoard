import QtQuick 2.12
import "../Elements"
import "../Elements/ElementHelper.js" as Element
import "../qmlHelper.js" as Qmlhelper

Item{
    id: iroot

    anchors.fill: parent

    property var currentElement: undefined
    property real handlesScale: 1 / iboard.scaleTransform.xScale
    property alias fakeLaser: ifakeLaser
    property alias board: iboard

    function toJson(){
        var json = {
            "elements":""
        }

        var elements = []
        for(var i= 0;i<iboard.elementContainer.children.length;i++){
            elements.push(iboard.elementContainer.children[i].json)
        }
        json.elements = elements
        return json
    }

    function fromJson(json){
        var elements = json.elements
        for(var i= 0;i<elements.length;i++){
            createElement(elements[i].type,elements[i])
        }

    }
    function binaryFiles(){
        var binaries = []
        for(var i= 0;i<iboard.elementContainer.children.length;i++){
            if(iboard.elementContainer.children[i].json.hasOwnProperty('tempName')){
                binaries.push(iboard.elementContainer.children[i].json.tempName)
            }
        }
        return binaries
    }

    function createElement(type, properties){
        var component = Qt.createComponent(Element.path(type))
        if(component.status === Component.Ready){
            var obj = component.createObject(iboard.elementContainer,properties)
            if(properties.common!==undefined){
                obj.fromJson(properties)
                obj.fromJsonBase(properties.common)
            }else{
                obj.created()
            }
            return obj
        }
        return null
    }
    function clear(){
        for(var i= 0;i<iboard.elementContainer.children.length;i++){
            iboard.elementContainer.children[i].destroy()
        }
    }
    function updatePosition(){
        var baseScale = Math.min(iwin.width /iboard.width,
                                 iwin.height /iboard.height)*0.9
        iboard.animeEnable = false
        iboard.scaleTransform.xScale = baseScale
        iboard.scaleTransform.yScale = baseScale
        iboard.moveCenter()
        iboard.animeEnable = true
    }

    Shortcut {
        sequence: StandardKey.Delete
        onActivated: {
            if(currentElement!==undefined)
                currentElement.deleteIt()
        }
    }
    Shortcut {
        sequence: StandardKey.Cancel
        onActivated: {
            currentElement = undefined
        }
    }
    Shortcut {
        sequence: StandardKey.ZoomIn
        onActivated: {
            iboard.scaleTransform.xScale += 0.1* iboard.scaleTransform.xScale
            iboard.scaleTransform.yScale += 0.1* iboard.scaleTransform.yScale
        }
    }
    Shortcut {
        sequence: StandardKey.ZoomOut
        onActivated: {
            iboard.scaleTransform.xScale -= 0.1* iboard.scaleTransform.xScale
            iboard.scaleTransform.yScale -= 0.1* iboard.scaleTransform.yScale
        }
    }

    Board{
        id: iboard
    }

    FakeLaser{
        id: ifakeLaser

        anchors.fill: parent
    }
    DropArea{
        anchors.fill: parent
        onEntered: {
            drag.accepted = drag.urls.length === 1 &&
                    Qmlhelper.isAppFile(drag.urls[0])
        }
        onDropped: {
            ifileManager.openAccepted(drop.urls[0])
        }
    }
}
