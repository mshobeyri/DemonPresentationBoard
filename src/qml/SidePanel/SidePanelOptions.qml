import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import ".."

ColumnLayout {
    id: ioptions

    width: parent.width - 20
    anchors.horizontalCenter: parent.horizontalCenter
    onVisibleChanged: {
        ioptions.forceActiveFocus()
    }
    function optionVisible(optionName){
        return iworld.currentElement!==null &&
                iworld.currentElement!==undefined &&
                iworld.currentElement.hasOwnProperty(optionName)
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
        visible: !optionVisible('animeTextFont')
        SidePanelLabelTextField{
            id: ixField
            label: "x"
            text: ioptions.visible?iworld.currentElement.x.toFixed(0):0
            onTextChanged:
                try{
                    if(textFocus)iworld.currentElement.x = text
                }catch(err){}
        }
        SidePanelLabelTextField{
            id: iyField
            label: "y"
            text: ioptions.visible?iworld.currentElement.y.toFixed(0):0
            onTextChanged:
                try{
                    if(textFocus)iworld.currentElement.y = text
                }catch(err){}
        }
    }
    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        visible: !optionVisible('animeTextFont')
        SidePanelLabelTextField{
            id: iwField
            label: "w"
            text: ioptions.visible?iworld.currentElement.w.toFixed(0):0
            onTextChanged:
                try{
                    if(textFocus)iworld.currentElement.w = text
                }catch(err){}
        }
        SidePanelLabelTextField{
            id: ihField
            label: "h"
            text: ioptions.visible?iworld.currentElement.h.toFixed(0):0
            onTextChanged:
                try{
                    if(textFocus)iworld.currentElement.h = text
                }catch(err){}
        }
    }
    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: izField
            label: "z"
            text: ioptions.visible?iworld.currentElement.z.toFixed(0):0
            onTextChanged:
                try{
                    if(textFocus)iworld.currentElement.z = text
                }catch(err){}
        }
        SidePanelLabelTextField{
            id: irField
            visible: !optionVisible('animeTextFont')
            label: "r"
            text: ioptions.visible?iworld.currentElement.r.toFixed(0):0
            onTextChanged:
                try{
                    if(textFocus)iworld.currentElement.r = text
                }catch(err){}
        }
    }

    SidePanelColorSelector{
        id: icolor
        label: "color"
        labelSize : iborderColor.labelSize
        visible: optionVisible('color')
        color: visible? iworld.currentElement.color:"white"
        onColorOutputChanged: if(visible)iworld.currentElement.color = colorOutput
    }
    SidePanelColorSelector{
        label: "text color"
        labelSize : iborderColor.labelSize
        visible: optionVisible('textColor')
        color: visible? iworld.currentElement.textColor:"white"
        onColorOutputChanged: if(visible)iworld.currentElement.textColor = colorOutput
    }
    SidePanelColorSelector{
        id: iborderColor

        visible: optionVisible('borderColor')
        label: "border color"
        color: visible? iworld.currentElement.borderColor:"white"
        onColorOutputChanged: if(visible)iworld.currentElement.borderColor = colorOutput
    }
    SidePanelColorSelector{
        visible: optionVisible('backgroundColor')
        labelSize : iborderColor.labelSize
        label: "background"
        color: visible? iworld.currentElement.backgroundColor:"white"
        onColorOutputChanged:  if(visible)iworld.currentElement.backgroundColor = colorOutput
    }
    SidePanelColorSelector{
        labelSize : iborderColor.labelSize
        visible: optionVisible('sepratorsColor')
        label: "seprators"
        color: visible? iworld.currentElement.sepratorsColor:"white"
        onColorOutputChanged:  if(visible)iworld.currentElement.sepratorsColor = colorOutput
    }
    SidePanelValueBox{
        visible: optionVisible('borderWidth')
        labelSize : iborderColor.labelSize
        label: "border width"
        value: visible? iworld.currentElement.borderWidth:0
        onValueChanged: if(visible)iworld.currentElement.borderWidth = value
    }
    SidePanelValueBox{
        visible: optionVisible('braceWidth')
        labelSize : iborderColor.labelSize
        label: "brace width"
        value: visible? iworld.currentElement.braceWidth:0
        onValueChanged:if(visible)iworld.currentElement.braceWidth = value
    }
    SidePanelValueBox{
        visible: optionVisible('rows')
        labelSize : iborderColor.labelSize
        label: "rows"
        value: visible? iworld.currentElement.rows:0
        onValueChanged: if(visible)iworld.currentElement.rows = value
    }
    SidePanelValueBox{
        visible: optionVisible('cols')
        labelSize : iborderColor.labelSize
        label: "columns"
        value: visible? iworld.currentElement.cols:0
        onValueChanged: if(visible)iworld.currentElement.cols = value
    }
    SidePanelValueBox{
        visible: optionVisible('spacing')
        labelSize : iborderColor.labelSize
        label: "spacing"
        value: visible? iworld.currentElement.spacing:0
        onValueChanged: if(visible)iworld.currentElement.spacing = value
    }
    SidePanelTextOptions{
        visible: optionVisible('textFont')
        textFont: visible? iworld.currentElement.textFont:""
        textJustify: visible? iworld.currentElement.textJustify:TextEdit.AlignLeft
    }
    SidePanelAnimationOption{
        visible: optionVisible('animeTextFont')
        textFont: visible? iworld.currentElement.animeTextFont:""
        textJustify: visible? iworld.currentElement.textJustify:TextEdit.AlignLeft
    }
    IconButton{
        visible: optionVisible('icon')
        iconStr: visible? iworld.currentElement.icon:""
        text: "Open Icon Gallery"
        Layout.fillWidth: true
        flat: true
        onClicked: iiconGallery.openGallery(iworld.currentElement)
    }
    IconButton{
        visible: optionVisible('chartTypeIcon')
        iconStr: visible? iworld.currentElement.chartTypeIcon:""
        text: "Open Chart Gallery"
        Layout.fillWidth: true
        flat: true
        onClicked: {
            ichartGallery.openGallery(iworld.currentElement)
        }
    }
    SidePanelVectorOptions{
        labelSize: icolor.labelSize
    }
    SidePanelPlayablesOption{
        Layout.fillWidth: true
    }
}
