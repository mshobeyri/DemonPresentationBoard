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
    property string color
    property string colorOutput: ""
    property bool visibleThemeColors: true

    RowLayout{
        width: parent.width
        SidePanelLabelTextField{
            id: icolorCodeTextField
            Layout.preferredWidth: 150
            label: "color"
            text: iroot.color
            validationRegex: /^#(([0-9a-fA-F]{3}){1,2}|([0-9a-fA-F]{8}))$|^background$|^foreground$|^border$|^primary$|^accent$/
            onTextChanged:  if(isValid)iroot.colorOutput = text
        }
        ChessBoard{
            Layout.preferredWidth: 20
            Layout.preferredHeight: 20
            anchors.margins: 1
            Rectangle{
                id: irect
                border.color: "black"
                border.width: 1
                layer.enabled: true
                anchors.fill: parent
                color: ithemeGallery.themeColor(iroot.color)
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    icolorCodeTextField.textFocus = false
                }
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
        visibleThemeColors: iroot.visibleThemeColors
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
                                 colorOutput = colorValue
    }
}
