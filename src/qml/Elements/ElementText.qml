import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property color color: "#333333"
    property color backgroundColor: "transparent"
    property font textFont
    property int textJustify: TextEdit.AlignLeft
    property var json: {
        "type": Element.text,
        "common": icontainer.commonData,
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
            color: icontainer.backgroundColor
            border.width: 1
            border.color: selected? Qt.lighter(itxt.color): "transparent"
            antialiasing: true
            clip: true
            TextEdit {
                id: itxt
                anchors.fill: parent
                anchors.margins: 2
                color: icontainer.color
                enabled: editMode
                text: "Your Text Here!"
                font: icontainer.textFont
                wrapMode: TextEdit.WordWrap
                horizontalAlignment: textJustify
            }
        }
    }
}
