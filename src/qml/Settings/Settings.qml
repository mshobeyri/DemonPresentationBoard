import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

CustomDialog {
    dialgTitle: "Menu"
    property alias appInterface: iinterface

    contentItem: SwipeView{
        id: iswipeView

        currentIndex: itabbar.currentIndex
        clip: true
        SettingsRemote{

        }
        SettingsInterface{
            id: iinterface
        }
    }
    footer: TabBar{
        id: itabbar
        currentIndex: iswipeView.currentIndex
        leftInset: 1
        rightInset: 1
        bottomInset: 1
        TabButton{
            text: "Remote"
        }
        TabButton{
            text: "Interface"
        }
    }
}
