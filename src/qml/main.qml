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
    title: "pl-illustrator"
    Material.theme: Material.Dark
    Material.accent: Material.Blue
    visibility: ApplicationWindow.Maximized

    FontLoader{
        id: ifontAwsome
        source: "qrc:/res/res/Font Awesome 5 Pro-Solid-900.otf"
    }
    FontLoader{
        id: ifontAwsomereg
        source: "qrc:/res/res/Font Awesome 5 Pro-Regular-400.otf"
    }
    FontLoader{
        id: ifontAwsomebrands
        source: "qrc:/res/res/Font Awesome 5 Brands-Regular-400.otf"
        Component.onCompleted: console.log(ifontAwsomebrands.name)
    }
    World{
        id: iworld
    }
    Timeline{
        id: itimeline
        worldFrame: iworld.frame
        onTimelienChanged: ifileManager.fileChanged()
    }
    SidePanel{
        id: isidePanel
    }
    SidePanelIconGallery{
        id: iiconGallery
    }
    FileManager{
        id: ifileManager

        application: iwin
        toFileFunc: function toFile(){
            var file = {
                "world":"",
                "timeline":""
            }
            file.world = iworld.toJson()
            file.timeline = itimeline.toJson()

            return JSON.stringify(file)
        }
        fromFileFunc: function fromFile(){

        }
        nameFilters:  ["pl-illustrator Files (*.pli)", "All files (*.*)"]
    }
}

