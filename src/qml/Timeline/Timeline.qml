import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

CustomDialog {
    id: iroot

    dialgTitle: "Timeline"
    visible: false

    property var worldFrame: undefined
    property var currentFrameModel: undefined
    property int easingType: Easing.InOutQuint
    property int duration: 1000

    function goPrev(){
        iframesGrid.goPrev()
    }

    function goNext(){
        iframesGrid.goNext()
    }

    function grabFrame(){
        appendFrame(worldFrame.x,worldFrame.y,worldFrame.scale,
                    worldFrame.rotation,0,"");
    }

    function appendFrame(x,y,scale,rotation,time,notes){
        iframesGrid.frameModel.append({"x": x ,
                                          "y": y,
                                          "scale": scale,
                                          "rotation": rotation,
                                          "time":time,
                                          "spendTime":0,
                                          "notes":notes})
    }

    function toJson(){
        var frames = []
        for(var i=0;i< iframesGrid.frameModel.count;i++){
            var frame = iframesGrid.frameModel.get(i)
            frames.push({"x":frame.x ,
                            "y":frame.y,
                            "scale":frame.scale,
                            "rotation":frame.rotation,
                            "time":frame.time,
                            "notes":frame.notes})
        }
        return frames
    }

    function fromJson(json){
        iframesGrid.frameModel.clear()
        for(var i = 0; i < json.length;i++){
            appendFrame(json[i].x,json[i].y,json[i].scale,
                        json[i].rotation,json[i].time,json[i].notes);
        }
    }
    signal timelienChanged

    Shortcut {
        sequence: StandardKey.MoveToNextChar
        onActivated: {
            goNext()
        }
    }
    Shortcut {
        sequence: StandardKey.MoveToPreviousChar
        onActivated: {
            goPrev()
        }
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
