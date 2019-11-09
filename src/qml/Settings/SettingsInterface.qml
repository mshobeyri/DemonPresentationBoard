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
    property var menuOpacity: imenusBackground.currentIndex === 0 ? 0.8:1

    QLS.Settings{
        id: isettings

        property alias theme: ithemeCombo.currentIndex
        property alias sidePannelEdge: isidePanelEdgeCombo.currentIndex
        property alias menuOpacity: imenusBackground.currentIndex
    }

    Column{
        spacing: 10
        Row{
            spacing: 10
            Label{
                text: "Theme"
                width: isidpaneledge.width
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: ithemeCombo
                model: ["Dark", "Light"]
            }
        }
        Row{
            spacing: 10
            Label{
                id: isidpaneledge

                text: "Side panel Edge"
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: isidePanelEdgeCombo

                model: ["Right", "Left"]
            }
        }
        Row{
            spacing: 10
            Label{
                text: "Visibility"
                width: isidpaneledge.width
                anchors.verticalCenter: parent.verticalCenter
            }
            ComboBox{
                id: imenusBackground

                model: ["Glassify", "Solid"]
            }
        }
    }
}
