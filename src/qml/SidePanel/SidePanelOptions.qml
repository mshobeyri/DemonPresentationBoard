import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

ColumnLayout {
    id: ioptions

    width: parent.width - 20
    anchors.horizontalCenter: parent.horizontalCenter
    onVisibleChanged: {
        ixField.textFocus = false
        iyField.textFocus = false
        iwField.textFocus = false
        ihField.textFocus = false
        izField.textFocus = false
        irField.textFocus = false
    }

    Row{
        Layout.alignment: Qt.AlignRight
        ToolButton{
            text: ioptions.visible?iworld.currentElement.locked?"unlock":"lock":""
            font.family: ifontAwsome.name
            onClicked: iworld.currentElement.locked = !iworld.currentElement.locked
        }

        ToolButton{
            text: ioptions.visible?iworld.currentElement.visible?"eye-slash":"eye":""
            font.family: ifontAwsome.name
            onClicked: iworld.currentElement.visible = !iworld.currentElement.visible
        }

        ToolButton{
            text: "trash-alt"
            font.family: ifontAwsome.name
            Material.foreground: Material.Red
            onClicked: iworld.currentElement.deleteIt()
        }
    }

    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: ixField
            label: "x"
            text: ioptions.visible?iworld.currentElement.x.toFixed(0):0
            onTextChanged: if(textFocus)iworld.currentElement.x = text
        }
        SidePanelLabelTextField{
            id: iyField
            label: "y"
            text: ioptions.visible?iworld.currentElement.y.toFixed(0):0
            onTextChanged: if(textFocus)iworld.currentElement.y = text
        }
    }
    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: iwField
            label: "w"
            text: ioptions.visible?iworld.currentElement.w.toFixed(0):0
            onTextChanged: if(textFocus)iworld.currentElement.w = Number(text)
        }
        SidePanelLabelTextField{
            id: ihField
            label: "h"
            text: ioptions.visible?iworld.currentElement.h.toFixed(0):0
            onTextChanged: if(textFocus)iworld.currentElement.h = Number(text)
        }
    }
    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: izField
            label: "z"
            text: ioptions.visible?iworld.currentElement.z.toFixed(0):0
            onTextChanged: if(textFocus)iworld.currentElement.z = Number(text)
        }
        SidePanelLabelTextField{
            id: irField
            label: "r"
            text: ioptions.visible?iworld.currentElement.r.toFixed(0):0
            onTextChanged: if(textFocus)iworld.currentElement.r = Number(text)
        }
    }

    SidePanelColorSelector{
        label: "color"
        labelSize : iborderColor.labelSize
        visible: iworld.currentElement!==undefined &&
                 iworld.currentElement.color!==undefined
        color: visible? iworld.currentElement.color:"white"
        onColorChanged: if(visible)iworld.currentElement.color = color
    }

    SidePanelColorSelector{
        id: iborderColor

        visible: iworld.currentElement!==undefined &&
                 iworld.currentElement.borderColor!==undefined
        label: "border color"
        color: visible? iworld.currentElement.borderColor:"white"
        onColorChanged: if(visible)iworld.currentElement.borderColor = color
    }
    SidePanelColorSelector{
        visible: iworld.currentElement!==undefined &&
                 iworld.currentElement.backgroundColor!==undefined
        label: "background"
        color: visible? iworld.currentElement.backgroundColor:"white"
        onColorChanged: if(visible)iworld.currentElement.backgroundColor = color
    }
    SidePanelValueBox{
        visible: iworld.currentElement!==undefined &&
                 iworld.currentElement.borderWidth!==undefined
        labelSize : iborderColor.labelSize
        label: "border width"
        value: visible? iworld.currentElement.borderWidth:0
        onValueChanged: if(visible)iworld.currentElement.borderWidth = value
    }
    SidePanelValueBox{
        visible: iworld.currentElement!==undefined &&
                 iworld.currentElement.braceWidth!==undefined
        labelSize : iborderColor.labelSize
        label: "brace width"
        value: visible? iworld.currentElement.braceWidth:0
        onValueChanged:if(visible)iworld.currentElement.braceWidth = value
    }
}
