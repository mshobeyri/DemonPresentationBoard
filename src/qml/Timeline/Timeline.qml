import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

CustomDialog {
    id: iroot

    dialgTitle: "Timeline"
    property var worldFrame: undefined
    property var currentFrameModel: undefined
    property int easingType: Easing.InOutQuint
    property int duration: 1000
    visible: false

    function grabFrame(){
        iframesGrid.frameModel.append({"rotation":worldFrame.rotation,
                                          "x":worldFrame.x ,
                                          "y":worldFrame.y,
                                          "scale":worldFrame.scale,
                                          "time":0,
                                          "spendTime":0,
                                          "notes":""})
    }

    function goPrev(){
        iframesGrid.goPrev()
    }
    function goNext(){
        iframesGrid.goNext()
    }
    Row{
        anchors.fill: parent
        FramesGrid{
            id: iframesGrid
            width: iwin.width / 6
            height: parent.height
        }
        ToolSeparator{
            height: parent.height
        }
        FrameOptions{

        }
    }
}
