import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property string text : ""
    property string color: "foreground"
    property string backgroundColor: "transparent"
    property font textFont
    property int textJustify: TextEdit.AlignLeft
    property var json: {
        "type": Element.text,
        "common": icontainer.commonData,
        "text": icontainer.text,
        "color": icontainer.color.toString(),
        "backgroundColor": icontainer.backgroundColor.toString(),
        "textFont": icontainer.textFont,
        "textJustify": icontainer.textJustify
    }
    function fromJson(json){
        color = json.color
        backgroundColor = json.backgroundColor
        textJustify = json.textJustify
        textFont.family = json.textFont.family
        textFont.bold = json.textFont.bold
        textFont.italic = json.textFont.italic
        textFont.pointSize = json.textFont.pointSize
    }

    onCreated: {
        textFont.pointSize = Math.floor(h / pixelDensity / 2.9)
        h = loader.item.placeHolder.paintedHeight
        w = loader.item.placeHolder.paintedWidth
    }

    onDoubleClicked:{
        icontainer.editMode = true
        currentElement = icontainer
    }
    onSelectedChanged: {
        if(!selected)
            icontainer.editMode = false
    }

    component:  Component {
        Rectangle{
            anchors.fill: parent
            color: ithemeGallery.themeColor(icontainer.backgroundColor)
            border.width: 1
            border.color: selected? Qt.lighter(itxt.color): "transparent"
            antialiasing: true
            clip: true
            property alias placeHolder: iplaceHolderText

            TextEdit {
                id: itxt

                property bool textChanged : false
                anchors.fill: parent
                anchors.margins: 2
                color: ithemeGallery.themeColor(icontainer.color)
                enabled: editMode
                text: icontainer.text
                font: icontainer.textFont
                wrapMode: TextEdit.WordWrap
                selectByMouse: true
                selectByKeyboard: true
                antialiasing: true
                horizontalAlignment: textJustify
                onEnabledChanged:{
                    if(enabled)
                        forceActiveFocus()
                }
                onEditingFinished: {
                    if(textChanged){
                        ifileManager.fileChanged()
                    }
                    textChanged = false
                }
                onTextChanged: {
                    if(focus){
                        textChanged = true
                        icontainer.text = text
                    }
                }
                Text {
                    id: iplaceHolderText

                    anchors.fill: parent
                    text: "Your Text Here!"
                    visible: !editMode && icontainer.text===""
                    font: parent.font
                    antialiasing: true
                    color: parent.color
                    horizontalAlignment: textJustify
                    wrapMode: TextEdit.WordWrap
                }
            }
        }
    }
}
