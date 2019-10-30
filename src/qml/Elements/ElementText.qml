import QtQuick 2.12

ElementBase{
    id: icontainer

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
            color: "transparent"
            border.width: 1
            border.color: selected? itxt.color: "transparent"
            clip: true
            TextEdit {
                id: itxt
                anchors.fill: parent
                anchors.margins: 2
                color: "white"
                enabled: editMode
                text: "salam"
                font.pixelSize: 14
                wrapMode: TextEdit.WordWrap
            }
        }
    }
}
