import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Dialog {
    id: iroot
    anchors.centerIn: parent
    contentWidth: icolumn.width
    contentHeight: icolumn.height
    title: "Notes Settings"

    property alias noteSize: inoteSize.value

    Column{
        id: icolumn
        spacing: 5
        Label{
            topPadding: 20
            text: "Size"
        }
        SpinBox{
            id: inoteSize
            value: 10
        }
    }
    footer: RowLayout{
        Item{
            Layout.fillWidth: true
        }
        Button{
            text: "Close"
            flat: true
            Material.foreground: Material.accent
            Layout.rightMargin: 10
            onClicked: {
                iroot.close()
            }
        }
    }
}
