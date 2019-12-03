import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Column{
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
            flat: true
            currentIndex: model.indexOf(textFont.family)
            onCurrentTextChanged: {
                if(focus && currentText!==""){
                    textFontOutput.family = currentText
                    if(iroot.visible)ifileManager.fileChanged()
                }
            }

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
                focusPolicy: Qt.NoFocus
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignLeft
                onToggled: {
                    textJustifyOutput = TextEdit.AlignLeft
                    //update position
                    updateCurrentElement()
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "align-center"
                checkable: true
                focusPolicy: Qt.NoFocus
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignHCenter
                onToggled: {
                    textJustifyOutput = TextEdit.AlignHCenter
                    //update position
                    updateCurrentElement()
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "align-right"
                checkable: true
                focusPolicy: Qt.NoFocus
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignRight
                onToggled: {
                    textJustifyOutput = TextEdit.AlignRight
                    //update position
                    updateCurrentElement()
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "align-justify"
                checkable: true
                focusPolicy: Qt.NoFocus
                width: height - topPadding
                flat: true
                checked: textJustify === TextEdit.AlignJustify
                onToggled: {
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
                focusPolicy: Qt.NoFocus
                width: height - topPadding
                flat: true
                checked: textFont.bold
                onToggled: {

                    textFontOutput.bold = checked
                }
            }
            Button{
                font.family: ifontAwsome.name
                text: "italic"
                checkable: true
                focusPolicy: Qt.NoFocus
                width: height - topPadding
                flat: true
                checked: textFont.italic
                onToggled: textFontOutput.italic = checked

            }
        }
    }
}
