import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

ColumnLayout{
    id: iroot

    width: parent.width - 20
    property int labelSize: iabouncance.labelSize
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
            onCurrentIndexChanged: iworld.board.background.type = currentIndex
        }
    }

    SidePanelColorSelector{
        visible: true
        labelSize : 100
        label: "color"
        color: visible? iworld.board.background.color:"white"
        onColorOutputChanged: if(visible &&
                                      iworld.board.background.color !== colorOutput)
                                  iworld.board.background.color = colorOutput
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

    SidePanelValueBox{
        label: "quality"
        labelSize: iroot.labelSize
        width: parent.width
        value: iworld.board.background.quality
        onValueChanged: iworld.board.background.quality = value
    }
    SidePanelValueBox{
        id: iabouncance

        label: "abundance"
        width: parent.width
        value: iworld.board.background.aboundance
        onValueChanged: iworld.board.background.aboundance = value
    }

    SidePanelValueBox{
        label: "velocity"
        labelSize: iroot.labelSize
        width: parent.width
        value: iworld.board.background.velocity
        onValueChanged: iworld.board.background.velocity = value
    }
}
