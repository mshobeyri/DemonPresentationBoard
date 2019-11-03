import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

Column{
    id: iroot

    width: parent.width
    property int labelSize: ilable.paintedWidth
    property int textJustify
    property font textFont
    property font defaultFont
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
        iworld.currentElement.textFont = textFontOutput
    }

    function updateCurrentElement(){
        textFontOutput.italic = !textFontOutput.italic
        textFontOutput.italic = !textFontOutput.italic
    }

    RowLayout {
        spacing: 10
        width: parent.width

        Label{
            id: ilable
            Layout.preferredWidth: labelSize
            text: "point size"
        }

        SpinBox{
            id: ispinbox
            Layout.fillWidth: true
            editable: true
            value: textFont.pointSize
            onValueChanged: textFontOutput.pointSize = value
        }
    }
    RowLayout {
        spacing: 10
        width: parent.width

        Label{
            Layout.preferredWidth: labelSize
            text: "font"
        }
        ComboBox{
            Layout.fillWidth: true
            model: Qt.fontFamilies()
            popup.x: -labelSize
            popup.width: iroot.width
            popup.height: iwin.height / 2
            currentIndex: model.indexOf(textFont.family)
            onCurrentTextChanged: if(focus)textFontOutput.family = currentText
            delegate: MenuItem{
                text: modelData
                font.family: modelData
            }
        }
    }
    ButtonGroup {
        buttons: itextAlignment.children
    }
    Row{
        spacing: 10
        anchors.horizontalCenter: parent.horizontalCenter
        Row{
            id: itextAlignment
            Button{
                font.family: ifontAwsome.name
                text: "align-left"
                checkable: true
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignLeft
                onCheckedChanged: {
                    textJustifyOutput = TextEdit.AlignLeft
                    //update position
                    updateCurrentElement()
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "align-center"
                checkable: true
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignHCenter
                onCheckedChanged: {
                    textJustifyOutput = TextEdit.AlignHCenter
                    //update position
                    updateCurrentElement()
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "align-right"
                checkable: true
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignRight
                onCheckedChanged: {
                    textJustifyOutput = TextEdit.AlignRight
                    //update position
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "align-justify"
                checkable: true
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignJustify
                onCheckedChanged: {
                    textJustifyOutput = TextEdit.AlignJustify
                    //update position
                   updateCurrentElement()
                }
            }
        }

        Row{
            Button{
                font.family: ifontAwsome.name
                text: "bold"
                checkable: true
                width: height - topPadding
                flat: true
                checked: textFont.bold
                onCheckedChanged: if(focus)textFontOutput.bold = checked
            }
            Button{
                font.family: ifontAwsome.name
                text: "italic"
                checkable: true
                width: height - topPadding
                flat: true
                checked: textFont.italic
                onCheckedChanged: if(focus)textFontOutput.italic = checked
            }
        }
    }
}
