import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Flickable {
    contentHeight: iheight.height
    width: parent.width
    interactive: height < contentHeight
    clip: true
    property var elements: ielements
    Column{
        id: iheight
        width: parent.width
        Label {
            text: qsTr("insert:")
            padding: 10
        }
        SidePanelElements{
            id: ielements
        }
        Label {
            text: qsTr("options:")
            padding: 10
            visible: iworld.currentElement!==undefined
        }
        SidePanelOptions{
            visible: iworld.currentElement!==undefined
        }
    }
}
