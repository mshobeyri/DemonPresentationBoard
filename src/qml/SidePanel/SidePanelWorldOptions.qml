import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

ColumnLayout{
    id: iroot

    width: parent.width - 20
    property int labelSize: ivelocity.paintedWidth
    anchors.horizontalCenter: parent.horizontalCenter

    RowLayout {
        spacing: 10
        width: parent.width

        Label{
            Layout.preferredWidth: labelSize
            text: "bg type"
        }
        ComboBox{
            Layout.fillWidth: true
            flat: true
            model: ["Color","Image","Pattern"]
            currentIndex: iworld.board.background.type
            onCurrentIndexChanged:  iworld.board.background.type = currentIndex
        }
    }

    SidePanelColorSelector{
        visible: true
        labelSize : 100
        label: "color"
        color: visible? iworld.board.background.color:"white"
        onColorOutputChanged: iworld.board.background.color = colorOutput
    }

    RowLayout {
        spacing: 10
        width: parent.width
        visible: iworld.board.background.type !== 0

        Label{
            Layout.preferredWidth: labelSize
            text: "image"
        }

        Button{
            text: "change image"
            onClicked: iworld.board.background.openImageSelector()
        }
    }
    RowLayout {
        spacing: 10
        width: parent.width
        visible: iworld.board.background.type === 1

        Label{
            Layout.preferredWidth: labelSize
            text: "quality"
        }

        SpinBox{
            Layout.fillWidth: true
            editable: true
            value: iworld.board.background.quality
            onValueChanged: iworld.board.background.quality = value
        }
    }
    RowLayout {
        spacing: 10
        width: parent.width
        visible: iworld.board.background.type ===2

        Label{
            Layout.preferredWidth: labelSize
            text: "abundance"
        }

        SpinBox{
            Layout.fillWidth: true
            editable: true
            value: iworld.board.background.aboundance
            onValueChanged: iworld.board.background.aboundance = value
        }
    }

    RowLayout {
        spacing: 10
        width: parent.width

        Label{
            id: ivelocity

            Layout.preferredWidth: labelSize
            text: "velocity"
        }

        SpinBox{
            Layout.fillWidth: true
            editable: true
            value: iworld.board.background.velocity
            onValueChanged: iworld.board.background.velocity = value
        }
    }
}
