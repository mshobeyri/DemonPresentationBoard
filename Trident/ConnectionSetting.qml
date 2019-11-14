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
            text: "IP"
        }
        TextField{
            id: iip
        }
        Label{
            text: "Port"
        }
        TextField{
            id: iport
        }
    }
    footer: Button{
        text: "OK"
        flat: true
        Material.foreground: Material.accent
        leftPadding: 10
        rightPadding: 10
        onClicked: {
            iconnection.url = "ws://"+iip.text+":"+iport.text
            iroot.close()
        }
    }
}
