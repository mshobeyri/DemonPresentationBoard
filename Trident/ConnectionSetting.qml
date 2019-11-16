import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Dialog {
    id: iroot
    anchors.centerIn: parent
    contentWidth: icolumn.width
    contentHeight: icolumn.height
    title: "Connection"
    Column{
        id: icolumn
        spacing: 5

        Label{
            topPadding: 20
            text: "Url"
        }
        Row{
            Label{
                text: "ws://"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -5
                leftPadding: 5
            }
            TextField{
                id: iip
            }
            Label{
                text: ":"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -5
                leftPadding: 5
                rightPadding: 5
            }
            TextField{
                id: iport
                width: iip.width/2
                placeholderText: "port"
            }
        }
    }
    footer: RowLayout{
        Item{
            Layout.fillWidth: true
        }
        Button{
            text: "Cancel"
            flat: true
            Material.foreground: Material.accent
            onClicked: {
                iroot.close()
            }
        }
        Button{
            text: "OK"
            flat: true
            Material.background: Material.accent
            Layout.rightMargin: 10
            onClicked: {
                iconnection.url = "ws://"+iip.text+":"+iport.text
                iroot.close()
            }
        }
    }
}
