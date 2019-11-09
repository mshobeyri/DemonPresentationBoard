import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

CustomDialog {
    id: iroot

    dialgTitle: "Welcome"
    property int columnsWidth: 250

    contentItem: RowLayout{
        spacing: 10
        ColumnLayout{
            Layout.preferredWidth: columnsWidth
            Layout.fillHeight: true
            IconButton{
                text: "New Project"
                iconStr: "file-plus"
                flat: true
            }
            Label{
                text: "Templates"
                font.pointSize: 14
            }
            Repeater{
                delegate: idelegate
                model: ListModel{
                    ListElement{
                        title: "ssss"
                        subtitle : "ajsdkjash dkja skdj akjs d"
                    }

                    ListElement{
                        title: "ssss"
                        subtitle : "ajsdkjash dkja skdj akjs d"
                    }

                    ListElement{
                        title: "ssss"
                        subtitle : "ajsdkjash dkja skdj akjs d"
                    }
                }
            }
            Item{
                Layout.preferredWidth: 10
                Layout.fillHeight: true
            }
        }
        ColumnLayout{
            Layout.preferredWidth: columnsWidth*2
            Layout.fillHeight: true
            IconButton{
                text: "Open Project"
                iconStr: "folder"
                flat: true
                onClicked: ifileManager.openBtnTriggered()
            }
            Label{
                text: "Recent Projects"
                font.pointSize: 14
            }
            Repeater{
                delegate: idelegate
                model: ifileManager.openRecentModel
            }
            Item{
                Layout.preferredWidth: 10
                Layout.fillHeight: true
            }
        }
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }

    Component{
        id: idelegate
        ItemDelegate{
            Layout.preferredWidth: columnsWidth
            height: icolomn.height
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
                    id: icolomn
                    spacing: 5

                    Label{
                        Material.foreground: Material.accent
                        text: model.title
                    }
                    Label{
                        Material.foreground: Material.Grey
                        text: model.subtitle
                    }
                }

            }
        }
    }
}
