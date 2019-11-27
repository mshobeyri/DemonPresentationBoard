import QtQuick 2.12
import "../Elements"
import "../Elements/ElementHelper.js" as Element
import "../qmlHelper.js" as Qmlhelper

Item{
    id: iroot

    width: Math.min(parent.width,parent.height*16/9)
    height: Math.min(parent.height,parent.width*9/16)
    anchors.centerIn: parent
    property var currentElement: undefined
    property real handlesScale: 1 / (iboard.xScale * iadjuster.scale)
    property alias fakeLaser: ifakeLaser
    property alias board: iboard

    Component.onCompleted: {
        updatePosition()
        iboard.x = 0.025 * iboard.width
        iboard.y = 0.025 * iboard.height
    }

    function toJson(){
        var json = {
            "elements":"",
            "board":""
        }

        var elements = []
        for(var i= 0;i<iboard.elementContainer.children.length;i++){
            elements.push(iboard.elementContainer.children[i].json)
        }
        json.elements = elements
        json.board = board.toJson();
        return json
    }

    function fromJson(json){
        var elements = json.elements
        for(var i= 0;i<elements.length;i++){
            createElement(elements[i].type,elements[i])
        }
        board.fromJson(json.board)
    }

    function binaryFiles(){
        var binaries = []
        for(var i= 0;i<iboard.elementContainer.children.length;i++){
            if(iboard.elementContainer.children[i].json.hasOwnProperty('tempName')){
                binaries.push(iboard.elementContainer.children[i].json.tempName)
            }
        }
        var boardImage = board.binaries()
        if(boardImage!==""){
            binaries.push(boardImage)
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
        var baseScale = Math.min(iwin.height /iboard.height,iwin.width/iboard.width)
        iadjuster.scale = baseScale * 0.95
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
            iboard.xScale += 0.1* iboard.xScale
            iboard.yScale += 0.1* iboard.yScale
        }
    }
    Shortcut {
        sequence: StandardKey.ZoomOut
        onActivated: {
            iboard.xScale -= 0.1* iboard.xScale
            iboard.yScale -= 0.1* iboard.yScale
        }
    }
    Item{
        id: iadjuster
        anchors.fill: parent
        transformOrigin: Item.TopLeft
        Board{
            id: iboard
        }
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
