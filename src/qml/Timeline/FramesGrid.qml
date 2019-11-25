import QtQuick 2.12
import QtQml.Models 2.12
import QtQuick.Controls 2.5

ListView {
    id: igrid

    clip: true
    displaced: Transition {
        NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
    }

    property alias frameModel: iframesModel

    function goCurrentFrame(){
        if(ianimations.running)
            ianimations.stop()
        if(currentItem!==null)
            currentFrameModel = currentItem.modelObj()
        ianimations.start()
    }
    function goPrev(){
        if(igrid.currentIndex > 0 )
            igrid.currentIndex--
    }

    function goNext(){
        if(igrid.currentIndex+1 < igrid.count)
            igrid.currentIndex++
    }

    function goTo(frame){
        igrid.currentIndex = frame - 1
    }
    function currentFrameData(){
        return {
            "data":frameModel.get(igrid.currentIndex),
            "index": igrid.currentIndex
        }
    }

    footer: Frame {
        width: iwin.width / 6 - 10
        height: iwin.height / 6 - 10
        scale: 0.9
        anchors.horizontalCenter: parent.horizontalCenter
        Rectangle{
            anchors.fill: parent
            opacity: iaddMouseArea.containsMouse?0.1:0
            Behavior on opacity {
                NumberAnimation{duration: 200}
            }
        }
        MouseArea{
            id: iaddMouseArea

            anchors.fill: parent
            hoverEnabled: true
            onClicked: grabFrame()
        }

        Label{
            anchors.centerIn: parent
            text: "plus"
            font.family: ifontAwsome.name
            font.pixelSize: parent.height/3 * 2
            opacity: 0.1
        }
    }

    onCurrentIndexChanged: {
        goCurrentFrame()
        iremoteHandler.sendFrameDataToTrident()
    }
    onCountChanged: {
        iremoteHandler.sendFramesNameToTrident()
    }

    ParallelAnimation{
        id: ianimations

        running: false
        PropertyAnimation{
            property: "x"
            target: board
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.x:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "y"
            target: board
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.y:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "xScale"
            target: board
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.scale:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "yScale"
            target: board
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.scale:0
            easing.type: easingType
            duration: iroot.duration
        }
    }
    model: DelegateModel {
        id: ivisualModel
        model: ListModel {
            id: iframesModel
            onCountChanged: timelienChanged()
        }
        delegate: MouseArea {
            id: idelegateRoot

            function index(){
                return model.index
            }
            function modelObj(){
                return model
            }
            function updateImage(){
                iworld.grabToImage(function(result) {
                    iimage.source = result.url;
                });
            }
            width: iwin.width / 6
            height: iwin.height / 6
            drag.target: icon
            scale: currentItem === idelegateRoot ? 1 : 0.9

            Behavior on scale {
                NumberAnimation{duration: 100}
            }

            property string name: DelegateModel.toString()
            property int selectedIndex: -1
            property int visualIndex: DelegateModel.itemsIndex

            Component.onCompleted: {
                updateImage()
            }

            onClicked: {
                currentIndex = model.index
                goCurrentFrame(model)
            }
            Rectangle {
                id: icon

                width: iwin.width / 6 - 10
                height: iwin.height/6 - 10
                color: "#333333"
                anchors {
                    horizontalCenter: parent.horizontalCenter;
                    verticalCenter: parent.verticalCenter
                }

                Drag.active: idelegateRoot.drag.active
                Drag.source: idelegateRoot
                Drag.hotSpot.x: width / 2
                Drag.hotSpot.y: height / 2
                Image{
                    id: iimage

                    width: parent.width
                    height: parent.height
                    visible: !ishaderEffectSource.live
                    onVisibleChanged: {
                        if(visible)
                            idelegateRoot.updateImage()
                    }
                }

                ShaderEffectSource {
                    id: ishaderEffectSource

                    width: parent.width
                    height: parent.height
                    anchors.centerIn: icon
                    textureSize: Qt.size(width,height)
                    sourceItem: iworld
                    live: (iframesGrid.currentIndex === model.index &&
                           board.x===model.x &&
                           board.y===model.y &&
                           board.xScale===model.scale)
                    onLiveChanged:{
                        if(live){
                            iworld.grabToImage(function(result) {
                                iremoteHandler.sendImage(result)
                            });
                            var m ={
                                "notes": model.notes
                            }
                            iremoteHandler.sendMessage(JSON.stringify(m))
                        }
                    }
                }


                Label{
                    anchors.centerIn: parent
                    text: model.index+1
                    font.pixelSize: parent.height/3 * 2
                    opacity: 0.1
                }

                states: [
                    State {
                        when: icon.Drag.active
                        ParentChange {
                            target: icon
                            parent: igrid
                        }

                        AnchorChanges {
                            target: icon;
                            anchors.horizontalCenter: undefined;
                            anchors.verticalCenter: undefined
                        }
                    }
                ]
            }
            DropArea {
                anchors { fill: parent; margins: 15 }
                onEntered:{
                    if(idelegateRoot.selectedIndex==-1){
                        selectedIndex = drag.source.visualIndex
                    }
                    iframesModel.move(drag.source.visualIndex,idelegateRoot.visualIndex,1)
                    timelienChanged()
                    sendFramesNameToTrident()
                }
            }
        }
    }
}
