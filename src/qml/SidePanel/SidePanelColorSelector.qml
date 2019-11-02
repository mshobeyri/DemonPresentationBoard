import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

ColumnLayout {
    id: iroot
    Layout.preferredWidth: 260
    property alias label: icolorCodeTextField.label
    property alias labelSize: icolorCodeTextField.labelSize
    property color color
    onColorChanged: {
        icolorCodeTextField.text = color
    }

    RowLayout{
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: icolorCodeTextField
            Layout.preferredWidth: 150
            label: "color"
            onTextChanged: color = text
        }
        ChessBoard{
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
            anchors.margins: 1
            Rectangle{
                color: icolorCodeTextField.text
                border.color: "black"
                border.width: 1
                layer.enabled: true
                anchors.fill: parent
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }
    ColorPicker{
        id: icolorPicker

        visible: icolorCodeTextField.textFocus
        height: visible? parent.width / 2 - 20:0
        Layout.preferredWidth: parent.width - 20
        Layout.preferredHeight: height
        opacity: !visible?0:1
        Layout.leftMargin: 20

        Behavior on height {
            NumberAnimation{duration: 300}
        }
        Behavior on opacity {
            NumberAnimation{duration: 300}
        }
        onColorValueChanged: iroot.color = colorValue

    }
    ToolButton{
        text: "check"
        font.family: ifontAwsome.name
        onClicked: icolorCodeTextField.textFocus = false
        visible: icolorCodeTextField.textFocus
        Layout.alignment: Qt.AlignRight
    }
}
