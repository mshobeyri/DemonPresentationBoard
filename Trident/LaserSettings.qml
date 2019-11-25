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
    property alias size: isize.value
    onColorChanged: {
        for(var i=0;i< icolorRepeater.count;i++){
            if(icolorRepeater.itemAt(i).backgroundColor === iroot.color){
                icolorRepeater.itemAt(i).checked = true
            }
        }
        iconnection.setLaserSettings()
        icolorRepeater.backgroundColor
    }

    ButtonGroup{
        buttons: icolorRow.children
    }

    Column{
        id: icolumn
        spacing: 5
        Label{
            text: "Color"
        }
        Row{
            id: icolorRow
            leftPadding: 10
            spacing: 5
            Repeater{
                id: icolorRepeater

                model: ["red","green","blue","yellow"]
                delegate: Button{
                    property string backgroundColor: modelData

                    flat: true
                    topInset: 0
                    bottomInset: 0
                    Material.background: backgroundColor
                    width: height
                    checkable: true
                    onClicked: {
                        iroot.color = modelData
                    }
                }
            }
        }
        Label{
            topPadding: 20
            text: "Size"
        }
        SpinBox{
            id: isize
            value: 20
            onValueChanged: {
                iconnection.setLaserSettings()
            }
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
