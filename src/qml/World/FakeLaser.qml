import QtQuick 2.12
import QtGraphicalEffects 1.12

Item {
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
        opacity: 0.8
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
