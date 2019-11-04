import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

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
                tooltip: "text"
                componentStr: "qrc:/src/qml/Elements/ElementText.qml"

            }
            ListElement{
                icon : "image"
                tooltip: "image"
                componentStr: "qrc:/src/qml/Elements/ElementImage.qml"
            }
            ListElement{
                icon : "video"
                tooltip: "media"
                componentStr: "qrc:/src/qml/Elements/ElementMedia.qml"
            }
            ListElement{
                icon : "browser"
                tooltip: "browser"
            }
            ListElement{
                icon : "rectangle-landscape"
                tooltip: "rectangle"
                componentStr: "qrc:/src/qml/Elements/ElementRectangle.qml"
            }
            ListElement{
                icon : "circle"
                tooltip: "circle"
                componentStr: "qrc:/src/qml/Elements/ElementCircle.qml"
            }
            ListElement{
                icon : "info-circle"
                tooltip: "icon"
                componentStr: "qrc:/src/qml/Elements/ElementIcon.qml"
            }
            ListElement{
                icon : "[ ]"
                tooltip: "bracket"
                componentStr: "qrc:/src/qml/Elements/ElementBracket.qml"
            }
            ListElement{
                icon : "walking"
                tooltip: "animation"
            }
            ListElement{
                icon : "long-arrow-right"
                tooltip: "arrow"
                componentStr: "qrc:/src/qml/Elements/ElementArrow.qml"
            }
            ListElement{
                icon : "table"
                tooltip: "table"
                componentStr: "qrc:/src/qml/Elements/ElementTable.qml"
            }
            ListElement{
                icon : "chart-line"
                tooltip: "chart"
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
            ToolTip.text: model.tooltip.toUpperCase()
            ToolTip.delay: 0
            ToolTip.visible: hovered

            onClicked: {
                if(model.index === currentSelected){
                    deselectAll()
                }else{
                    currentSelected = model.index
                    insertCandidateComponent = model.componentStr
                }
            }
        }
    }
}
