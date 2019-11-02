import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

Frame {
    padding: 0
    Column{
        width: parent.width
        RowLayout{
            anchors{
                right: parent.right
                left: parent.left
                margins: 10
            }
            spacing: 10
            Button{
                text: "Open timeline panel"
                Material.background: Material.DeepPurple
                flat: true
                Layout.fillWidth: true
                onClicked: itimeline.open()
            }
            Button{
                Material.background: Material.Green
                text: "plus"
                font.family: ifontAwsome.name
                flat: true
                ToolTip.text: "Grab Frame"
                ToolTip.visible: hovered
                Layout.preferredWidth: height
                onClicked: itimeline.grabFrame()
            }
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Button{
                text: "Prev"
                flat: true
                Material.background: Material.Indigo
                onClicked: itimeline.goPrev()
            }

            Button{
                text: "Next"
                flat: true
                Material.background: Material.Indigo
                onClicked: itimeline.goNext()
            }
        }
    }
}
