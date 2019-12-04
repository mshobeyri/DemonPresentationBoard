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
            id: iinsertLabel
            text: qsTr("Insert")
            padding: 10
            visible: ielements.visible
            font.pointSize: 12
            Material.foreground: Material.accent
        }
        SidePanelElements{
            id: ielements

            visible: isettings.appInterface.insertAlwaysVisible ||
                iworld.currentElement===undefined
        }
        MenuSeparator{
            visible:iinsertLabel.visible
            width: parent.width
        }

        Label {
            text: qsTr("Options")
            Material.foreground: Material.accent
            padding: 10
            font.pointSize: 12
        }
        SidePanelOptions{
            visible: iworld.currentElement!==undefined &&
                     iworld.currentElement!==null
        }

        SidePanelWorldOptions{
            id: iworldOption

            Component.onCompleted: iworld.worldOptions = iworldOption
            visible: iworld.currentElement===undefined ||
                     iworld.currentElement===null
        }
    }
}
