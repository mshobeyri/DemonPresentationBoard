import QtQuick 2.12
import "../Elements"
import "../Elements/ElementHelper.js" as Element

Item{
    id: iroot

    anchors.fill: parent

    property var currentElement: undefined
    property alias frame: iframe
    property real handlesScale: 1 / iframe.scale

    function toJson(){
        var json = {
            "elements":""
        }

        var elements = []
        for(var i= 0;i<ielementContainer.children.length;i++){
            elements.push(ielementContainer.children[i].json)
        }
        json.elements = elements
        return json
    }

    function fromJson(json){
        var elements = json.elements
        for(var i= 0;i<elements.length;i++){
            crateElement(elements[i].type,elements[i])
        }

    }
    function crateElement(type, properties){
        var component = Qt.createComponent(Element.path(type))
        if(component.status === Component.Ready){
            var obj = component.createObject(ielementContainer,properties)
            if(properties.common!==undefined){
                obj.fromJson(properties)
                obj.fromJsonBase(properties.common)
            }else if(type === Element.image || type ===Element.media){
                obj.created()
            }
        }
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
            iframe.scale += 0.1 * iframe.scale
        }
    }
    Shortcut {
        sequence: StandardKey.ZoomOut
        onActivated: {
            iframe.scale -= 0.1* iframe.scale
        }
    }
    Shortcut {
        sequence: StandardKey.MoveToPreviousWord
        onActivated: {
            iframe.rotation --
        }
    }
    Shortcut {
        sequence: StandardKey.MoveToNextWord
        onActivated: {
            iframe.rotation ++
        }
    }


    Rectangle {
        id: iframe

        antialiasing: true
        color: "#9da8b3"
        x: (iroot.width - width) / 2
        y: (iroot.height - height) / 2
        width: 1920
        height: 1080
        scale: Math.min(iroot.width / width,iroot.height/height)*0.95
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

        MouseArea {
            id: iframeMouseArea

            anchors.fill: parent
            drag.axis: Drag.XAndYAxis
            drag.target: iframe
            preventStealing: false
            hoverEnabled: true
            onClicked: {
                if(isidePanel.insertCandidateComponent!==""){
                    crateElement(isidePanel.insertCandidateComponent, {x:mouseX,y:mouseY})
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

        Item{
            id: ielementContainer

            anchors.fill: parent
        }
    }
}
