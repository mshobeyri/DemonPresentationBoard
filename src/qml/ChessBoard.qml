import QtQuick 2.12

Item {
    id: iroot
    property int cellCount: 5
    Grid{
        id: ichessBoard
        flow: Grid.LeftToRight
        anchors.fill: parent
        rows: (width/cellCount)!==0?height / (width/cellCount):0
        columns: cellCount
        clip: true
        Repeater {
            model: ichessBoard.columns*ichessBoard.rows
            Rectangle {
                width: iroot.width/iroot.cellCount
                height: width
                color: (index % 2 === 0) ? "gray" : "white"
            }
        }
    }
}
