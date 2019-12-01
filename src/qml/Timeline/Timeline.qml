import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

CustomDialog {
    id: iroot

    dialgTitle: "Timeline"
    visible: false

    property var board: undefined
    property var currentFrameModel: undefined
    property int easingType: Easing.InOutQuint
    property int duration: 1000

    function goPrev(){
        iframesGrid.goPrev()
    }

    function goNext(){
        iframesGrid.goNext()
    }
    function goTo(frame){
        iframesGrid.goTo(frame)
    }

    function grabFrame(){
        var bg = board.boardGeometry()
        var id = Qt.md5(Qt.formatTime(new Date(),"yyyyMMddhhmmsszzz"))
        appendFrame(id,bg.x,bg.y,bg.scale,"",0,"","")
        iroot.open()
    }

    function appendFrame(id,x,y,scale,name,time,notes,image){
        iframesGrid.frameModel.append({
                                          "id": id,
                                          "x": x,
                                          "y": y,
                                          "scale": scale,
                                          "name":name,
                                          "time":time,
                                          "spendTime":0,
                                          "notes":notes,
                                          "image":image})
    }

    function currentFrameData(){
        return iframesGrid.currentFrameData()
    }

    function framesName(){
        var frames = []
        for(var i=0;i< iframesGrid.frameModel.count;i++){
            var frame = iframesGrid.frameModel.get(i)
            if(frame.name!=="")
                frames.push(frame.name)
            else{
                frames.push("frame "+ (i+1))
            }
        }
        return frames
    }

    function toJson(){
        var frames = []
        for(var i=0;i< iframesGrid.frameModel.count;i++){
            var frame = iframesGrid.frameModel.get(i)
            frames.push({
                            "id":frame.id,
                            "x":frame.x ,
                            "y":frame.y,
                            "scale":frame.scale,
                            "name":frame.name,
                            "time":frame.time,
                            "notes":frame.notes,
                            "image":frame.image})
        }
        return frames
    }

    function fromJson(json){
        for(var i=0 ; i< json.length;i++){
            var f = json[i]
            appendFrame(f.id,f.x,f.y,f.scale,f.name,f.time,f.notes,f.image)
        }
    }
    function clear(){
        iframesGrid.frameModel.clear()
    }

    function getFrameIndex(id){
        for(var i=0;i< iframesGrid.frameModel.count;i++){
            if(id === iframesGrid.frameModel.get(i).id){
                return i
            }
        }
    }

    signal timelineChanged
    signal timelineFrameOrderChanged
    signal timelineFrameChanged(var index)

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
