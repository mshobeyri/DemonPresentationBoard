import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import Qt.labs.settings 1.1

Item{
    width: parent.width
    height: parent.height

    property var container: icontainer
    property string insertCandidateComponent : ""
    property Rectangle panelsPosition: Rectangle{
        x: idrawer.edge === Qt.RightEdge?
               idrawer.visible?10: 10 + idrawer.width/2:
               idrawer.visible? idrawer.width + 10: idrawer.width/2
        y: 10
        width: iwin.width - 20 - idrawer.width
        height: iwin.height - 20
    }

    Settings{
        property alias pinnedDrawer: ipinDrawerBtn.checked
    }

    MouseArea{
        id: icloseDrawer

        x: idrawer.edge === Qt.RightEdge? 0: idrawer.width
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
        anchors.right: idrawer.edge === Qt.RightEdge?
                           parent.right:parent.left
        onEntered: {
            idrawer.open()
        }
    }
    Drawer {
        id: idrawer

        height: parent.height
        width: 260
        dim: false
        edge: isettings.appInterface.sidePannelEdge
        background: Rectangle{
            opacity: isettings.appInterface.menuOpacity
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
            spacing: 0
            RowLayout{

                Button{
                    text: "bars"
                    flat: true
                    font.family: ifontAwsome.name

                    Layout.preferredWidth: height
                    onClicked: imenu.open()
                }

                Item{
                    Layout.fillWidth: true
                }

                ToolButton{
                    id: ipinDrawerBtn
                    text: "thumbtack"
                    flat: true
                    font.family: ifontAwsome.name
                    font.bold: true
                    checkable: true
                    checked: true
                    font.pixelSize: height / 4.5
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
    SidePanelMenu{
        x: idrawer.x
        id: imenu
    }
}
