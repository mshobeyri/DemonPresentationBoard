import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

Pane {
    leftInset: 1
    Column{
        width: parent.width
        MenuSeparator{width: parent.width}
        RowLayout{
            width: parent.width
            spacing: 5

            Button{
                text: "Prev"
                flat: true
                ToolTip.text: "Move Previous Frame"
                ToolTip.visible: hovered
                Material.background: Material.Indigo
                Material.foreground: "white"
                Layout.fillWidth: true
                onClicked: itimeline.goPrev()
            }

            Button{
                text: "Next"
                flat: true
                ToolTip.text: "Move Next Frame"
                ToolTip.visible: hovered
                Material.background: Material.Indigo
                Material.foreground: "white"
                Layout.fillWidth: true
                onClicked: itimeline.goNext()
            }
            Button{
                text: "project-diagram"
                Material.background: Material.DeepPurple
                Material.foreground: "white"
                flat: true
                Layout.preferredWidth: height
                ToolTip.text: "Open Timeline Menu"
                ToolTip.visible: hovered
                font.family: ifontAwsome.name
                onClicked: itimeline.open()
            }
            Button{
                Material.background: Material.Green
                Material.foreground: "white"
                text: "plus"
                font.family: ifontAwsome.name
                flat: true
                ToolTip.text: "Grab Frame"
                ToolTip.visible: hovered
                Layout.preferredWidth: height
                onClicked: itimeline.grabFrame()
            }
        }
    }
}
