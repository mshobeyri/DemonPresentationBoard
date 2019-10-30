import QtQuick 2.12

ElementBase{
    id: icontainer

    property bool editMode: false
    property int rows: 3
    property int cols: 2
    property color backgroundColor: "red"
    property color tableColor: "blue"
    property color textColor: "white"
    property int spacing: 4

    onDoubleClicked:{
        editMode = true
        currentElement = icontainer
    }
    onSelectedChanged: {
        if(!selected)
            editMode = false
    }

    component:  Component {
        Rectangle{
            color: tableColor
            clip: true
            GridView{
                anchors.fill: parent
                model: ["asda","asdas","asda","asasdasdasas","asda","asdas"]
                interactive: false
                cellWidth: parent.width/icontainer.cols
                cellHeight: parent.height/icontainer.rows
                delegate: Item{
                    width: parent.width/icontainer.cols
                    height: parent.height/icontainer.rows
                    Rectangle{
                        width: parent.width -icontainer.spacing
                        height: parent.height -icontainer.spacing
                        color: icontainer.backgroundColor
                        anchors.centerIn: parent
                        TextEdit {
                            id: itxt
                            anchors.fill: parent
                            color:icontainer.textColor
                            enabled: editMode
                            text: model.modelData
                            font.pixelSize: 14
                            wrapMode: TextEdit.WordWrap
                            horizontalAlignment: TextEdit.AlignHCenter
                            verticalAlignment: TextEdit.AlignVCenter
                        }
                    }
                }
            }
        }
    }
}
