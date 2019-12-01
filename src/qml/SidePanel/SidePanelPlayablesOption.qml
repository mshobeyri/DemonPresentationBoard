import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

ColumnLayout {
    id: iroot

    visible: optionVisible('evokeInIndex')
    MenuSeparator{
        Layout.fillWidth: true
    }
    Label{
        text: "auto play"
        Material.foreground: Material.accent
        Layout.alignment: Qt.AlignHCenter
    }

    Button{
        text: visible?"Play In This Frame":""
        Layout.fillWidth: true
        Layout.topMargin: 10
        flat: true
        onClicked: {
            if(!visible || itimeline.currentFrameData().data === undefined)
                return
            iworld.currentElement.evokeInId = itimeline.currentFrameData().data.id
            iworld.currentElement.evokeInIndex = itimeline.currentFrameData().index
        }
    }
    Label{
        Layout.alignment: Qt.AlignCenter
        visible: optionVisible('animeTextFont')
        text:{
            if(!visible) ""
            if(visible && iworld.currentElement.evokeInIndex >=0){
                "play frame: Frame"+ (iworld.currentElement.evokeInIndex+1)
            }else{
                "play frame: No Frame"
            }
        }
    }
}
