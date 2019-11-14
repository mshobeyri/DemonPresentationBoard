import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Dialog {
    id: iroot
    anchors.centerIn: parent
    contentWidth: icolumn.width
    contentHeight: icolumn.height
    title: "Laser Settings"
    property string color: "red"
    ButtonGroup{
        buttons: icolorRow.children
    }

    Column{
        id: icolumn
        spacing: 5
        Label{
            text: "color"
        }
        Row{
            id: icolorRow
            leftPadding: 10
            spacing: 5
            Repeater{
                model: ["red","green","blue","yellow"]
                delegate: Button{
                    flat: true
                    topInset: 0
                    bottomInset: 0
                    Material.background: modelData
                    width: height
                    checkable: true
                    onClicked: iroot.color = modelData
                }
            }
        }
        Label{
            topPadding: 20
            text: "size"
        }
        SpinBox{
            id: isize
            value: 20
        }
    }
    footer: Button{
        text: "OK"
        flat: true
        Material.foreground: Material.accent
        leftPadding: 10
        rightPadding: 10
        onClicked: {
            iconnection.setLaserSettings(iroot.color,isize.value)
            iroot.close()
        }
    }
}
