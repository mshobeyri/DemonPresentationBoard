import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

ApplicationWindow {
    visible: true
    width: 380
    height: 640
    title: qsTr("Demon Trident")
    Material.accent: "red"
    Material.theme: Material.Dark

    property string imageData: ""
    property string notes: ""

    header: ToolBar{
        topPadding: 0
        Layout.fillWidth: true
        Material.background: Material.accent
        RowLayout{
            width: parent.width
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                font.family: ifontAwsome.name
                text: "cogs"
                onClicked: iconnectionSetting.open()
            }
        }
    }
    FontLoader{
        id: ifontAwsome
        source: "qrc:/../res/Font Awesome 5 Pro-Solid-900.otf"
    }

    Connection{
        id: iconnection
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        RowLayout{
            Layout.fillWidth: true
            Label{
                text: "LASER"
                font.pointSize: 14
                Material.foreground: Material.accent
            }
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                font.family: ifontAwsome.name
                text: "cog"
                onClicked: ilaserSetting.open()
            }
        }
        Frame{
            Layout.fillWidth: true
            Layout.preferredHeight: parent.width *9/16
            Material.elevation: 7
            padding: 0
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

                width: parent.width/1.5
                height: parent.height/1.5
                source: "qrc:/../res/logo.png"
                fillMode: Image.PreserveAspectFit
                anchors.centerIn: parent
            }

            Image{
                anchors.fill: parent
                source: imageData!==""?"data:image/png;base64," + imageData:""
            }
        }
        RowLayout{
            Layout.fillWidth: true
            Layout.topMargin: 20
            Label{
                text: "Notes"
                font.pointSize: 14
                Material.foreground: Material.accent
            }
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                font.family: ifontAwsome.name
                text: "cog"
                onClicked: inotesSetting.open()
            }
        }
        Flickable{
            contentHeight: inotes.paintedHeight
            Layout.leftMargin: 10
            Layout.rightMargin: 10
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            interactive: contentHeight>height
            Label{
                id: inotes

                font.pointSize: inotesSetting.noteSize
                wrapMode: "WordWrap"
                text: notes!==""?notes : "No Note Available"
            }
        }
    }

    LaserSettings{
        id: ilaserSetting
    }
    NotesSettings{
        id: inotesSetting
    }
    ConnectionSetting{
        id: iconnectionSetting
    }

    footer: ToolBar{
        Material.background: Material.accent
        RowLayout{
            width: parent.width
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
            ComboBox{
                model: ["Name of god"]
                Layout.fillWidth: true
                flat: true
                indicator.rotation: 180
            }
        }
    }
}
