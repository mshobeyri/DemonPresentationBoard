import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3


Pane {
    id: iroot
    anchors.fill: parent
    anchors.margins: 20
    visible: true
    background: Rectangle{
        opacity: 0.5
    }
    property var worldFrame: undefined
    property var currentFrameModel: undefined
    property int easingType: Easing.InOutQuint
    property int duration: 1000

    function grabFrame(){
        iframesGrid.frameModel.append({"rotation":worldFrame.rotation,
                               "x":worldFrame.x ,
                               "y":worldFrame.y,
                               "scale":worldFrame.scale})
    }

    FramesGrid{
        id: iframesGrid
        anchors.fill: parent
        anchors.rightMargin: 400
    }
}
