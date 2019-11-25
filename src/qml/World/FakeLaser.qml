import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
    property alias color: ilaserPoint.color
    property alias size: ilaserPoint.width
    function setLaserSetting(laserColor,laserSize){
        color = laserColor
        size = laserSize
    }

    function pointTo(x,y){
        if(x === -1){
            ilaserPoint.visible = false
        }else{
            ilaserPoint.visible = true
            ilaserPoint.x = x * width
            ilaserPoint.y = y * height
        }
    }

    Rectangle{
        id: ilaserPoint

        width: 15
        height: width
        radius: width
        color: "red"
        opacity: 0.65
        visible: false
        RectangularGlow {
              anchors.fill: parent
              glowRadius: parent.width
              spread: 0.3
              color: parent.color
              cornerRadius: parent.radius + glowRadius
          }
    }
}
