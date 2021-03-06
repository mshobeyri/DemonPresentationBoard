import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

ColumnLayout{
    id: iroot

    width: parent.width
    property int labelSize: ianimeDuration.labelSize
    property int textJustify
    property font textFont
    property int textJustifyOutput
    property font textFontOutput
    onTextFontChanged: textFontOutput = textFont
    onTextJustifyChanged: textJustifyOutput = textJustifyOutput
    onTextJustifyOutputChanged: {
        if(visible)
            iworld.currentElement.textJustify = textJustifyOutput
    }

    onTextFontOutputChanged: {
        if(visible)
            iworld.currentElement.animeTextFont = textFontOutput
    }

    function updateCurrentElement(){
        textFontOutput.italic = !textFontOutput.italic
        textFontOutput.italic = !textFontOutput.italic
    }

    SidePanelTextFormatOptions{

    }
    MenuSeparator{
        Layout.fillWidth: true
    }

    Label{
        text: "parameters"
        Material.foreground: Material.accent
        Layout.alignment: Qt.AlignHCenter
    }
    Button{
        id: ievokeBtn
        visible: optionVisible('animeTextFont')
        text: "Evoked"
        Layout.fillWidth: true
        Layout.topMargin: 10
        flat: true
        checkable: true
        checked: visible?iworld.currentElement.evoked:false
        onToggled: {
            if(iroot.visible)iworld.currentElement.evoked = checked
        }
    }

    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: ixField
            label: "x"
            text: ioptions.visible?iworld.currentElement.x.toFixed(0):0
            onTextChanged: if(textFocus){
                               ievokeBtn.checked?
                                           iworld.currentElement.x2 = Number(text)
                                         : iworld.currentElement.x1 = Number(text)
                               iworld.currentElement.x = Number(text)
                           }
        }
        SidePanelLabelTextField{
            id: iyField
            label: "y"
            text: ioptions.visible?iworld.currentElement.y.toFixed(0):0
            onTextChanged: if(textFocus){
                               ievokeBtn.checked?
                                           iworld.currentElement.y2 = Number(text)
                                         : iworld.currentElement.y1 = Number(text)
                               iworld.currentElement.y = Number(text)
                           }
        }
    }
    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: iwField
            label: "w"
            text: ioptions.visible?iworld.currentElement.w.toFixed(0):0
            onTextChanged: if(textFocus){
                               ievokeBtn.checked?
                                           iworld.currentElement.w2 = Number(text)
                                         : iworld.currentElement.w1 = Number(text)
                               iworld.currentElement.w = Number(text)
                           }
        }
        SidePanelLabelTextField{
            id: ihField
            label: "h"
            text: ioptions.visible?iworld.currentElement.h.toFixed(0):0
            onTextChanged: if(textFocus){
                               ievokeBtn.checked?
                                           iworld.currentElement.h2 = Number(text)
                                         : iworld.currentElement.h1 = Number(text)
                               iworld.currentElement.h = Number(text)
                           }
        }
    }
    RowLayout{
        spacing: 10
        Layout.fillWidth: true
        SidePanelLabelTextField{
            id: irField
            label: "r"
            text: ioptions.visible?iworld.currentElement.r.toFixed(0):0
            onTextChanged: if(textFocus){
                               ievokeBtn.checked?
                                           iworld.currentElement.r2 = Number(text)
                                         : iworld.currentElement.r1 = Number(text)
                               iworld.currentElement.r = Number(text)
                           }
        }
        Item{
            Layout.fillWidth: true
        }
    }

    SidePanelValueBox{
        id: ipointSize

        label: "pixel size"
        visible: optionVisible('fontSize')
        value: visible?iworld.currentElement.fontSize:0
        width: parent.width
        onValueChanged: if(iroot.visible){
                            ievokeBtn.checked?
                                        iworld.currentElement.s2= value
                                      :iworld.currentElement.s1= value
                            iworld.currentElement.fontSize= value
                        }
    }

    SidePanelColorSelector{
        id: icolor
        label: "color"
        labelSize : iborderColor.labelSize
        color: iroot.visible? ievokeBtn.checked?iworld.currentElement.color2:
                                           iworld.currentElement.color1:"white"
        onColorOutputChanged: if(iroot.visible){
                                  ievokeBtn.checked?
                                              iworld.currentElement.color2= colorOutput
                                            :iworld.currentElement.color1= colorOutput
                                  iworld.currentElement.textColorHelper= colorOutput
                              }
    }
    SidePanelColorSelector{
        labelSize : iborderColor.labelSize
        label: "background"
        color: iroot.visible?ievokeBtn.checked?
                            iworld.currentElement.backgroundColor2
                          :iworld.currentElement.backgroundColor1:"white"
        onColorOutputChanged:  if(iroot.visible){
                                   ievokeBtn.checked?
                                               iworld.currentElement.backgroundColor2= colorOutput
                                             :iworld.currentElement.backgroundColor1= colorOutput
                                   iworld.currentElement.textBackgroundColor= colorOutput
                               }
    }
    MenuSeparator{
        Layout.fillWidth: true
    }

    Label{
        text: "animation"
        Material.foreground: Material.accent
        Layout.alignment: Qt.AlignHCenter
    }

    SidePanelValueBox{
        id: ianimeDuration
        Layout.topMargin: 10
        visible: optionVisible('animeTextFont')
        label: "duration"
        value: visible?iworld.currentElement.animationDuration:0
        Layout.fillWidth: true
        onValueChanged: if(iroot.visible)iworld.currentElement.animationDuration = value
    }
    RowLayout {
        spacing: 10
        width: parent.width

        Label{
            Layout.preferredWidth: labelSize
            text: "easing"
        }
        ComboBox{
            visible: optionVisible("easingType")
            Layout.fillWidth: true
            model: ["Linear",
                "In Quad",
                "Out Quad",
                "In Out Quad",
                "Out In Quad",
                "In Cubic",
                "Out Cubic",
                "In Out Cubic",
                "Out In Cubic",
                "In Quart",
                "Out Quart",
                "In Out Quart",
                "Out In Quart",
                "In Quint",
                "Out Quint",
                "In Out Quint",
                "Out In Quint",
                "InSine",
                "OutSine",
                "In OutSine",
                "Out InSine",
                "In Expo",
                "Out Expo",
                "In Out Expo",
                "Out In Expo",
                "In Circ",
                "Out Circ",
                "In Out Circ",
                "Out In Circ",
                "In Elastic",
                "Out Elastic",
                "In Out Elastic",
                "Out In Elastic",
                "In Back",
                "Out Back",
                "In Out Back",
                "Out In Back",
                "In Bounce",
                "Out Bounce",
                "In Out Bounce",
                "Out In Bounce"]
            popup.x: -labelSize
            popup.width: iroot.width
            popup.height: iwin.height / 2
            flat: true
            currentIndex: visible?iworld.currentElement.easingType:0
            onCurrentTextChanged: if(iroot.visible)iworld.currentElement.easingType =
                                             currentIndex
            delegate: MenuItem{
                text: modelData
                font.family: modelData
            }
        }
    }
}
