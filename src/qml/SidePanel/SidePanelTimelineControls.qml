import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

Pane {
    leftInset: 1
    background: Rectangle{
        color: "transparent"
    }

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
                Layout.fillWidth: true
                onClicked: itimeline.goPrev()
            }

            Button{
                text: "Next"
                flat: true
                ToolTip.text: "Move Next Frame"
                ToolTip.visible: hovered
                Layout.fillWidth: true
                onClicked: itimeline.goNext()
            }
            Button{
                text: "project-diagram"
                flat: true
                Layout.preferredWidth: height
                ToolTip.text: "Open Timeline Menu"
                ToolTip.visible: hovered
                font.family: ifontAwsome.name
                onClicked: itimeline.open()
            }
            Button{
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
