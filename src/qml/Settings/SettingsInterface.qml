import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt.labs.settings 1.0 as QLS

Item {
    id: iroot

    property var theme: ithemeCombo.currentIndex===0?
                            Material.Dark:Material.Light
    property var sidePannelEdge: isidePanelEdgeCombo.currentIndex===0?
                                     Qt.RightEdge:Qt.LeftEdge
    property var menuOpacity: imenusBackground.currentIndex === 0 ? 0.9:1
    property bool insertAlwaysVisible: iinsertVisibility.currentIndex === 0
    property int comboWidth: 300

    QLS.Settings{
        id: isettings

        property alias theme: ithemeCombo.currentIndex
        property alias sidePannelEdge: isidePanelEdgeCombo.currentIndex
        property alias menuOpacity: imenusBackground.currentIndex
        property alias insertVisibility: iinsertVisibility.currentIndex
    }

    Column{
        spacing: 10
        Row{
            spacing: 10
            Label{
                text: "Theme"
                width: iinsertVisibilityLabel.width
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: ithemeCombo
                model: ["Dark", "Light"]
                width: comboWidth
            }
        }
        Row{
            spacing: 10
            Label{
                text: "Side panel Edge"
                width: iinsertVisibilityLabel.width
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: isidePanelEdgeCombo

                model: ["Right", "Left"]
                width: comboWidth
            }
        }
        Row{
            spacing: 10
            Label{
                text: "Visibility"
                width: iinsertVisibilityLabel.width
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: imenusBackground

                model: ["Glassify", "Solid"]
                width: comboWidth
            }
        }
        Row{
            spacing: 10
            Label{
                id: iinsertVisibilityLabel

                text: "Insert Menu visibility"
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: iinsertVisibility

                model: ["Always visible", "Visible if no item selected"]
                width: comboWidth
            }
        }
    }
}
