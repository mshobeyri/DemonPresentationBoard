import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import ".."

Flickable {
    id: iroot
    visible: iframesGrid.currentIndex!==-1 &&
             iframesGrid.currentItem!==null
    height: parent.height
    contentHeight: icol.height
    width: iwin.width / 3
    clip: true
    Column{
        id: icol
        spacing: 5
        Label{
            text: "Frame Name:"
        }

        TextField{
            width: iroot.width
            selectByMouse: true
            placeholderText: "set a name to this frame"
            text: iroot.visible ?iframesGrid.currentItem.modelObj().name:""
            onTextChanged: {
                if(!focus)
                    return
                iframesGrid.frameModel.setProperty(
                               iframesGrid.currentIndex,"name",text)
                timelienChanged()
                iremoteHandler.sendFramesNameToTrident()
            }
        }
        Item{
            width: 10
            height: 10
        }
        Label{
            text: "Frame Time(min):"
        }
        SpinBox{
            value: iroot.visible?iframesGrid.currentItem.modelObj().time:0
            onValueChanged: {
                iframesGrid.frameModel.setProperty(
                                iframesGrid.currentIndex,"time",value)
                timelienChanged()
                iremoteHandler.sendFrameDataToTrident()
            }
        }
        Item{
            width: 10
            height: 10
        }

        Label{
            text: "Key Notes:"
        }

        TextArea{
            width: iroot.width
            wrapMode: "WrapAnywhere"
            selectByKeyboard: true
            selectByMouse: true
            placeholderText: "write some note for this frame ..."
            text: iroot.visible ?iframesGrid.currentItem.modelObj().notes:""
            onTextChanged: {
                if(!focus)
                    return
                iframesGrid.frameModel.setProperty(
                               iframesGrid.currentIndex,"notes",text)
                timelienChanged()
                iremoteHandler.sendFrameDataToTrident()
            }
        }
        Item{
            width: 10
            height: 10
        }

        Label{
            text: "Control:"
        }

        IconButton{
            flat: true
            iconStr: "trash-alt"
            text: "delete frame"
            onClicked: {
                iframesGrid.frameModel.remove(iframesGrid.currentIndex)
                iframesGrid.currentIndex = -1
            }
        }
    }
}
