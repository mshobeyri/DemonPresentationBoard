import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import QtWebSockets 1.1

ApplicationWindow {
    visible: true
    width: 380
    height: 640
    title: qsTr("Demon Trident")
    Material.accent: Material.Cyan
    Material.theme: Material.Dark

    property string imageData: ""
    property string notes: ""

    header:    ToolBar{
        topPadding: 0
        Layout.fillWidth: true
    }
    FontLoader{
        id: ifontAwsome
        source: "qrc:/../../res/Font Awesome 5 Pro-Solid-900.otf"
    }

    Connection{
        id: iconnection
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        Label{
            text: "LASER"
            font.pointSize: 14
            Material.foreground: Material.accent
        }
        Frame{
            Layout.fillWidth: true
            Layout.preferredHeight: parent.width *9/16
            Material.elevation: 7
            MouseArea{
                anchors.fill: parent
                onReleased: iconnection.fakeLaser(-1,-1)
                onMouseXChanged: containsMouse?
                                     iconnection.fakeLaser(mouseX/width,mouseY/height):
                                     iconnection.fakeLaser(-1,-1)

                onMouseYChanged: containsMouse?
                                     iconnection.fakeLaser(mouseX/width,mouseY/height):
                                     iconnection.fakeLaser(-1,-1)


            }
            Image{
                anchors.fill: parent
                source: imageData!==""?"data:image/png;base64," + imageData:""
            }
        }
        Label{
            text: "NOTES"
            font.pointSize: 14
            Layout.topMargin: 20
            Material.foreground: Material.accent
        }

        Label{
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            wrapMode: "WordWrap"
            text: notes
        }
    }
    footer: ToolBar{
        Row{
            ToolButton{
                font.family: ifontAwsome.name
                text: "angle-left"
                onClicked: iconnection.goPrev()
            }
            ToolButton{
                font.family: ifontAwsome.name
                text: "angle-right"
                onClicked: iconnection.goNext()
            }
        }
    }
}
