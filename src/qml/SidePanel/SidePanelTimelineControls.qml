import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Pane {
    padding: 0
    Column{
        width: parent.width
        Button{
            text: "Open timeline panel"
            Material.background: Material.DeepPurple
            width: parent.width
            flat: true
            onClicked: itimeline.grabFrame()
        }
        Row{
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            Button{
                text: "Prev"
                flat: true
                Material.background: Material.Indigo
            }

            Button{
                text: "Next"
                flat: true
                Material.background: Material.Indigo
            }
        }
    }
}
