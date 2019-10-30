import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import "SidePanel"
import "World"
import "Timeline"
ApplicationWindow {
    id: iwin
    visible: true
    width: 800
    height: 600
    title: qsTr("pl-illustrator")
    Material.theme: Material.Dark
    Material.accent: Material.BlueGrey

    FontLoader{
        id: ifontAwsome
        source: "qrc:/res/res/Font Awesome 5 Pro-Solid-900.otf"
    }
    FontLoader{
        id: ifontAwsomereg
        source: "qrc:/res/res/Font Awesome 5 Pro-Regular-400.otf"
    }
    World{
        id: iworld
    }
    Timeline{
        id: itimeline
        worldFrame: iworld.frame
    }
    SidePanel{
        id: isidePanel
    }
}
