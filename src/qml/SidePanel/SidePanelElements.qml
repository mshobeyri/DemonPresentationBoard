import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import "../Elements/ElementHelper.js" as Element
Grid {
    id: iroot
    columns: 4
    rows: 3
    anchors.horizontalCenter: parent.horizontalCenter
    property int currentSelected: -1
    function deselectAll(){
        ibuttonGroup.checkState = Qt.Unchecked
        currentSelected = -1
        insertCandidateComponent = ""
    }
    ButtonGroup {
        id: ibuttonGroup
        buttons: iroot.children
    }
    Repeater{
        model: ListModel{
            ListElement{
                icon : "file-alt"
                name: "text"
            }
            ListElement{
                icon : "image"
                name: "image"
            }
            ListElement{
                icon : "video"
                name: "media"
            }
            ListElement{
                icon : "Σ"
                disable: true
                name: "formula(not implemented)"
            }
            ListElement{
                icon : "rectangle-landscape"
                name: "rectangle"
            }
            ListElement{
                icon : "circle"
                name: "circle"
            }
            ListElement{
                icon : "info-circle"
                name: "icon"
            }
            ListElement{
                icon : "[ ]"
                name: "bracket"
            }
            ListElement{
                icon : "font"
                name: "animation"
            }
            ListElement{
                icon : "long-arrow-right"
                name: "arrow"
            }
            ListElement{
                icon : "table"
                name: "table"
            }
            ListElement{
                icon : "chart-line"
                name: "chart"
            }
        }
        delegate: Button{
            id: ibutton
            text: model.icon
            flat: true
            font.family: ifontAwsome.name
            leftInset: 5
            rightInset: 5
            enabled: model.disable!==undefined && !model.disable
            width: height
            checkable: true
            ToolTip.text: model.name.toUpperCase()
            ToolTip.delay: 0
            ToolTip.visible: hovered
            onToggled: {
                checked = !checked
                if(model.index === currentSelected){
                    deselectAll()
                }else{
                    currentSelected = model.index
                    insertCandidateComponent = model.name
                }
            }
            Image{
                id: dragItem
                source: ""
                Drag.active: dragArea.drag.active
                Drag.keys: [ "element" ]
                Drag.dragType: Drag.Automatic
                Drag.supportedActions: Qt.CopyAction
                Drag.hotSpot : Qt.point(30,30)
                property string type: model.name
                property string key: "element"
            }

            MouseArea{
                id:dragArea
                anchors.fill: parent
                drag.target: dragItem
                onClicked: {
                    parent.onToggled();
                }
                onPositionChanged: {
                    parent.grabToImage(function(result) {
                        dragItem.Drag.imageSource = result.url
                    })
                }
            }
        }
    }
}
