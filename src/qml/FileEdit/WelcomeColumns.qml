import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."


ColumnLayout{
    property int buttonWidth: 250
    property alias button: ibutton
    property alias label: ilabel.text
    property alias model: ifilesRepeater.model
    Layout.preferredWidth: ifilesRepeater.width
    IconButton{
        id: ibutton

        text: "Open Project"
        iconStr: "folder"
        flat: true
        Layout.preferredWidth: buttonWidth
        onClicked: ifileManager.openBtnTriggered()
        Frame{
            anchors.fill: parent
            anchors.topMargin:  parent.topInset
            anchors.bottomMargin: parent.bottomInset
        }
    }
    Label{
        id: ilabel

        text: "Recent Projects"
        font.pointSize: 14
    }
    ListView{
        id: ifilesRepeater

        width: contentWidth
        model: ifileManager.openRecentModel
        Layout.fillHeight: true
        delegate: ItemDelegate{
            height: irow.height
            implicitWidth: irow.width
            hoverEnabled: true
            onClicked: {
                if(!fileio.fileExist(model.subtitle)){
                    ifileManager.openRecentModel.remove(model.index)
                    return
                }

                ifileManager.open(model.subtitle)
                iroot.close()
            }
            Row{
                id: irow

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
                        Material.foreground: Material.accent
                        text: model.title
                    }
                    Label{
                        Material.foreground: Material.Grey
                        text: model.subtitle
                        width: paintedWidth
                    }
                }

            }
        }
    }
    Item{
        Layout.preferredWidth: 10
        Layout.fillHeight: true
    }
}
