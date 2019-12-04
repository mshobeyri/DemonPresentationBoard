import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

CustomDialog {
    id: iwelcome

    property bool firstShine: true
    dialgTitle: "Welcome"
    closable: !firstShine
    modal: firstShine
    onClosed: {
        firstShine = false
    }
    Shortcut {
        sequence: StandardKey.New
        onActivated: {
            ifileManager.newButtonTriggered()
        }
    }

    Shortcut {
        sequence: StandardKey.Open
        onActivated: {
            ifileManager.openBtnTriggered()
        }
    }

    RowLayout{
        spacing: 10
        anchors.fill: parent
        WelcomeColumns{
            Layout.minimumWidth: 250
            Layout.fillHeight: true
            button.text: "New Project"
            button.iconStr: "file-plus"
            label: "Templates"
            onBtnClicked: {
                ifileManager.newButtonTriggered()
            }
            onItemClicked: {
                ifileManager.openAccepted(":/res/res/"+subtitle)
                ifileManager.resetFile()
                iwelcome.close()
            }
            model: ListModel{
                ListElement{
                    title: "about"
                    subtitle : "Templates/about.dpb"
                }
            }
        }
        WelcomeColumns{
            button.text: "Open Project"
            button.iconStr: "folder"
            label: "Recent Projects"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumWidth: 250
            itemsWidth: 250
            model: ifileManager.openRecentModel
            onBtnClicked: {
                ifileManager.openBtnTriggered()
            }
            onItemClicked: {
                if(!fileio.fileExist(subtitle)){
                    ifileManager.openRecentModel.remove(index)
                    return
                }
                ifileManager.openAccepted(subtitle)
                iwelcome.close()
            }
        }
        Item{
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
    Label{
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        text: "Copyright © Mehrdad Shobeyri  2019 - V "+Qt.application.version
        font.pixelSize: 11
    }
}
