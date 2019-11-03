import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

Column {
    id: iroot

    Layout.preferredWidth: parent.width - 20
    property alias label: icolorCodeTextField.label
    property alias labelSize: icolorCodeTextField.labelSize
    property color color

    RowLayout{
        width: parent.width
        SidePanelLabelTextField{
            id: icolorCodeTextField
            Layout.preferredWidth: 150
            label: "color"
            text: iroot.color
            onTextChanged: {
                if(iroot.visible)
                    color = text
            }
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
            MouseArea{
                anchors.fill: parent
                onClicked: icolorCodeTextField.textFocus = false
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
        }
    }

    ColorPicker{
        id: icolorPicker

        visible: opacity!==0
        width: parent.width - 20
        height: icolorCodeTextField.textFocus ?parent.width / 2 - 20:0
        opacity: icolorCodeTextField.textFocus?1:0
        Layout.leftMargin: 20
        clip: true

        Behavior on height {
            NumberAnimation{duration: 200}
        }
        Behavior on opacity {
            NumberAnimation{duration: 200}
        }
        onColorValueChanged: if(visible)
                                 icolorCodeTextField.text = colorValue
    }
}
