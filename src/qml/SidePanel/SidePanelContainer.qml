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

            visible: iworld.currentElement===undefined
        }
        SidePanelElements{
            id: ielements

            visible: iworld.currentElement===undefined
        }
        Label {
            text: qsTr("options:")
            padding: 10
        }
        SidePanelOptions{
            visible: iworld.currentElement!==undefined
        }

        SidePanelWorldOptions{
            visible: iworld.currentElement===undefined
        }
    }
}
