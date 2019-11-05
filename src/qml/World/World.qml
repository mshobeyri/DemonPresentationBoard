import QtQuick 2.12
import "../Elements"
import "../Elements/ElementHelper.js" as Element

Item{
    id: iroot

    anchors.fill: parent

    property var currentElement: undefined
    property alias surface: isurface
    property real handlesScale: 1 / isurface.scale

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
            isurface.scale += 0.1 * isurface.scale
        }
    }
    Shortcut {
        sequence: StandardKey.ZoomOut
        onActivated: {
            isurface.scale -= 0.1* isurface.scale
        }
    }
    Shortcut {
        sequence: StandardKey.MoveToPreviousWord
        onActivated: {
            isurface.rotation --
        }
    }
    Shortcut {
        sequence: StandardKey.MoveToNextWord
        onActivated: {
            isurface.rotation ++
        }
    }


    Rectangle {
        id: isurface

        antialiasing: true
        color: "#9da8b3"
        x: (iroot.width - width) / 2
        y: (iroot.height - height) / 2
        width: 1920
        height: 1080
        scale: Math.min(iroot.width / width,iroot.height/height)*0.95
        PinchArea{
            anchors.fill: parent
            pinch.target: isurface
            pinch.minimumRotation: -360
            pinch.maximumRotation: 360
            pinch.minimumScale: 0.1
            pinch.maximumScale: 10
            pinch.dragAxis: Pinch.XAndYAxis
            property real zRestore: 0
            onSmartZoom: {
                if (pinch.scale > 0) {
                    isurface.rotation = 0;
                    isurface.scale = Math.min(root.width, root.height) / Math.max(image.sourceSize.width, image.sourceSize.height) * 0.85
                    isurface.x = flick.contentX + (flick.width - isurface.width) / 2
                    isurface.y = flick.contentY + (flick.height - isurface.height) / 2
                    zRestore = isurface.z
                    isurface.z = ++root.highestZ;
                } else {
                    isurface.rotation = pinch.previousAngle
                    isurface.scale = pinch.previousScale
                    isurface.x = pinch.previousCenter.x - isurface.width / 2
                    isurface.y = pinch.previousCenter.y - isurface.height / 2
                    isurface.z = zRestore
                    --root.highestZ
                }
            }
        }

        MouseArea {
            id: iframeMouseArea

            anchors.fill: parent
            drag.axis: Drag.XAndYAxis
            drag.target: isurface
            preventStealing: false
            hoverEnabled: true
            onClicked: {
                if(isidePanel.insertCandidateComponent!==""){
                    crateElement(isidePanel.insertCandidateComponent,
                                 {x:mouseX,y:mouseY,rotation: - isurface.rotation})
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
                    isurface.rotation += wheel.angleDelta.y / 120 * 5;
                    if (Math.abs(isurface.rotation) < 4)
                        isurface.rotation = 0;
                } else {
                    isurface.rotation += wheel.angleDelta.x / 120;
                    if (Math.abs(isurface.rotation) < 0.6)
                        isurface.rotation = 0;
                    var scaleBefore = isurface.scale;
                    isurface.scale += isurface.scale * wheel.angleDelta.y / 120 / 10;
                }
            }
        }

        Item{
            id: ielementContainer

            anchors.fill: parent
        }
    }
}
