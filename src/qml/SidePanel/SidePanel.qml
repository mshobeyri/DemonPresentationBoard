import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import Qt.labs.settings 1.1

Item{
    width: parent.width
    height: parent.height
    anchors.right: parent.right
    property var container: icontainer
    property string insertCandidateComponent : ""
    property Rectangle panelsPosition: Rectangle{
        x: idrawer.visible?10: 10 + idrawer.width/2
        y: 10
        width: iwin.width - 20 - idrawer.width
        height: iwin.height - 20
    }

    Settings{
        property alias pinnedDrawer: ipinDrawerBtn.checked
    }

    MouseArea{
        id: icloseDrawer
        width: iwin.width - idrawer.width
        height: iwin.height
        onEntered: {
            idrawer.close()
        }
        hoverEnabled: true
        visible: idrawer.position!==0 && !ipinDrawerBtn.checked
    }
    MouseArea{
        width: 20
        height: parent.height
        hoverEnabled: true
        anchors.right: parent.right
        onEntered: {
            idrawer.open()
        }
    }
    Drawer {
        id: idrawer
        height: parent.height
        width: 260
        dim: false
        edge: Qt.RightEdge
        background: Rectangle{
            opacity: 0.9
            color: Material.background
        }

        closePolicy: Drawer.NoAutoClose
        visible: ipinDrawerBtn.checked
        interactive: false
        modal: false
        ToolSeparator{
            height: parent.height
            anchors.left: parent.Left
            leftInset: 0
            leftPadding: 0
        }

        ColumnLayout{
            anchors.fill: parent
            RowLayout{

                Button{
                    text: "cog"
                    flat: true
                    font.family: ifontAwsome.name
                    leftInset: 5
                    rightInset: 5
                    width: height
                }

                Item{
                    Layout.fillWidth: true
                }

                Button{
                    id: ipinDrawerBtn
                    text: "thumbtack"
                    flat: true
                    font.family: ifontAwsome.name
                    font.bold: true
                    checkable: true
                    checked: true
                    scale: 0.7
                    leftInset: 5
                    rightInset: 5
                    width: height
                }
            }
            MenuSeparator{
                topPadding: 0
                Layout.fillWidth: true
            }

            SidePanelContainer{
                id: icontainer
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            SidePanelTimelineControls{
                Layout.fillWidth: true
            }
        }
    }
}
