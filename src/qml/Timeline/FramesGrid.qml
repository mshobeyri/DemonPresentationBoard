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

    onCurrentIndexChanged: goCurrentFrame()

    ParallelAnimation{
        id: ianimations

        running: false
        PropertyAnimation{
            property: "x"
            target: worldFrame
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.x:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "y"
            target: worldFrame
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.y:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "scale"
            target: worldFrame
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.scale:0
            easing.type: easingType
            duration: iroot.duration
        }
        RotationAnimation {
            property: "rotation";
            target: worldFrame
            to:currentFrameModel!==undefined && currentFrameModel!==null
               ?currentFrameModel.rotation:0
            direction:RotationAnimation.Shortest
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

                ShaderEffectSource {
                    width: parent.width
                    height: parent.height
                    recursive: true
                    anchors.centerIn: icon
                    sourceItem: iworld
                    live: (worldFrame.x===model.x &&
                           worldFrame.y===model.y &&
                           worldFrame.scale===model.scale &&
                           worldFrame.rotation===model.rotation)
                }
                Label{
                    anchors.centerIn: parent
                    text: model.index
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
                }
            }
        }
    }
}
