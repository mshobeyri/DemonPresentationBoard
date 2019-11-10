import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."


ColumnLayout{
    id: iroot

    property int buttonWidth: 250
    property int itemsWidth: buttonWidth
    property alias button: ibutton
    property alias label: ilabel.text
    property alias model: ifilesRepeater.model

    signal btnClicked
    signal itemClicked(var subtitle,var index)
    IconButton{
        id: ibutton

        text: "Open Project"
        iconStr: "folder"
        flat: true
        Layout.preferredWidth: buttonWidth
        onClicked: btnClicked()
        Frame{
            anchors.fill: parent
            anchors.topMargin:  parent.topInset
            anchors.bottomMargin: parent.bottomInset
            enabled: false
        }
    }
    Label{
        id: ilabel

        text: "Recent Projects"
        font.pointSize: 14
    }
    ListView{
        id: ifilesRepeater

        Layout.preferredWidth: itemsWidth
        Layout.fillHeight: true
        flickableDirection: Flickable.AutoFlickDirection
        interactive: true
        clip: true
        delegate: ItemDelegate{
            height: irow.height + 10
            width: itemsWidth
            hoverEnabled: true
            onClicked: {
                itemClicked(model.subtitle,model.index)
            }
            Row{
                id: irow
                Component.onCompleted: if(width>itemsWidth)itemsWidth = width + 10
                anchors.verticalCenter: parent.verticalCenter
                leftPadding: 10
                topPadding: 2
                spacing: 5
                Label{
                    Material.foreground: Material.Grey
                    text: "file"
                    font.family: ifontAwsome.name
                    font.pointSize: 12
                }
                Column{
                    spacing: 5
                    Label{
                        font.pointSize: 10
                        Material.foreground: Material.accent
                        text: model.title
                    }
                    Label{
                        font.pointSize: 8
                        Material.foreground: Material.Grey
                        text: model.subtitle
                        width: paintedWidth
                    }
                }
            }
        }
    }
}
