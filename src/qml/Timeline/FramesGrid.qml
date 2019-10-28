import QtQuick 2.12
import QtQml.Models 2.12

GridView {
    id: igrid
    property alias frameModel: iframesModel

    displaced: Transition {
        NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
    }
    cellWidth : iwin.width / 6 + 10
    cellHeight:  iwin.height / 6 + 10

    function goFrame(model){
        if(ianimations.running)
            ianimations.stop()
        currentFrameModel = model
        ianimations.start()
    }

    ParallelAnimation{
        id: ianimations
        running: false
        PropertyAnimation{
            property: "x"
            target: worldFrame
            to:currentFrameModel!==undefined?currentFrameModel.x:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "y"
            target: worldFrame
            to:currentFrameModel!==undefined?currentFrameModel.y:0
            easing.type: easingType
            duration: iroot.duration
        }
        PropertyAnimation{
            property: "scale"
            target: worldFrame
            to:currentFrameModel!==undefined?currentFrameModel.scale:0
            easing.type: easingType
            duration: iroot.duration
        }
        RotationAnimation {
            property: "rotation";
            target: worldFrame
            to:currentFrameModel!==undefined?currentFrameModel.rotation:0
            direction:RotationAnimation.Shortest
            easing.type: easingType
            duration: iroot.duration
        }
    }
    model: DelegateModel {
        id: ivisualModel
        model: ListModel {
            id: iframesModel
        }
        delegate: MouseArea {
            id: idelegateRoot

            width: iwin.width / 6
            height: iwin.height / 6
            drag.target: icon

            property string name: DelegateModel.toString()
            property int selectedIndex: -1
            property int releaseIndex: -1
            property int visualIndex: DelegateModel.itemsIndex
            onClicked: goFrame(model)
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
                    //                       firstIndex = drag.source.visualIndex+1
                    //                       secondIndex = delegateRoot.visualIndex+1
                    iframesModel.move(drag.source.visualIndex,idelegateRoot.visualIndex,1)
                    //                       for(var i=0;i<animationVideoModel.count;i++)animationVideoModel.setProperty(i,"signal",signal++)
                }
            }
        }
    }
}
