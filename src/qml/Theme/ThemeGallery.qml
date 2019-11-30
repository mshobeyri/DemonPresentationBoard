import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."
import "../SidePanel"


CustomDialog {
    id: iroot

    dialgTitle: "Theme gallery"

    property string name: ""
    property color backgroundColor: "red"
    property color foregroundColor: "white"
    property color borderColor: "green"
    property color primaryColor: "yellow"
    property color accentColor: "blue"

    function themeColor(color){
        switch(color){
        case "background":
            return backgroundColor
        case "foreground":
            return foregroundColor
        case "border":
            return borderColor
        case "primary":
            return primaryColor
        case "accent":
            return accentColor
        default:
            return color
        }
    }
    Row{
        height: parent.height
        ListView{
            id: ilistview

            width: 300
            height: parent.height
            currentIndex: -1
            clip: true
            model: ListModel{
                ListElement{
                    name: "hell"
                    background: "red"
                    foreground : "white"
                    border: "red"
                    primary: "blue"
                    accent: "yellow"
                    editable: false
                }
                ListElement{
                    name: "heaven"
                    background: "red"
                    foreground : "white"
                    border: "red"
                    primary: "blue"
                    accent: "yellow"
                    editable: false
                }
                ListElement{
                    name: "qt"
                    background: "red"
                    foreground : "white"
                    border: "red"
                    primary: "blue"
                    accent: "yellow"
                    editable: false
                }
                ListElement{
                    name: "sand"
                    background: "red"
                    foreground : "white"
                    border: "red"
                    primary: "blue"
                    accent: "yellow"
                    editable: false
                }
                ListElement{
                    name: "sand"
                    background: "red"
                    foreground : "white"
                    border: "green"
                    primary: "blue"
                    accent: "yellow"
                    editable: true
                }
            }

            section.delegate: Label{
                topPadding: 20
                text: section==="false"?"user themes":"demon themes"
                Material.foreground: Material.accent
            }
            section.property: "editable"
            delegate: MenuItem{
                width: 300
                text: model.name
                highlighted: model.index === ilistview.currentIndex
                onClicked: {
                    iroot.name = model.name
                    ilistview.currentIndex = model.index
                    backgroundColor = model.background
                    foregroundColor = model.foreground
                    borderColor = model.border
                    primaryColor = model.primary
                    accentColor = model.accent
                }

                Row{
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    height: parent.height / 5
                    Rectangle{
                        color: model.background
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.foreground
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.border
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.primary
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.accent
                        width: parent.height
                        height: width
                    }
                }
            }
        }
        ToolSeparator{
            height: parent.height
        }

        ColumnLayout{
            width: 300
            visible: ilistview.currentIndex!==-1
            SidePanelLabelTextField{
                label: "Name"
            }

            SidePanelColorSelector{
                id: ibackgrondColorSelector
                color: backgroundColor
                label: "Background"
                onColorOutputChanged: backgroundColor = colorOutput
                visibleThemeColors: false
            }
            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: foregroundColor
                label: "Foreground"
                onColorOutputChanged: foregroundColor = colorOutput
                visibleThemeColors: false
            }
            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: borderColor
                label: "Border"
                onColorOutputChanged: borderColor = colorOutput
                visibleThemeColors: false
            }

            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: primaryColor
                label: "Primary"
                onColorOutputChanged: primaryColor = colorOutput
                visibleThemeColors: false
            }

            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: accentColor
                label: "Accent"
                onColorOutputChanged: accentColor = colorOutput
                visibleThemeColors: false
            }
        }
    }
}
