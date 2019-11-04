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
                icon : "browser"
                name: "browser"
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
                icon : "walking"
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
            Material.background: Material.Indigo
            font.family: ifontAwsome.name
            leftInset: 5
            rightInset: 5
            width: height
            checkable: true
            ToolTip.text: model.name.toUpperCase()
            ToolTip.delay: 0
            ToolTip.visible: hovered

            onClicked: {
                if(model.index === currentSelected){
                    deselectAll()
                }else{
                    currentSelected = model.index
                    insertCandidateComponent = model.name
                }
            }
        }
    }
}
