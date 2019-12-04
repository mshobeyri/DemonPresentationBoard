import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Window 2.12
import "SidePanel"
import "SidePanel/Chart"
import "Theme"
import "World"
import "Timeline"
import "Settings"
import "FileEdit"

ApplicationWindow {
    id: iwin
    visible: true
    width: 800
    height: 600
    minimumWidth: 800
    minimumHeight: 600
    Material.theme: isettings.appInterface.theme
    Material.accent: Material.Teal
    visibility: ApplicationWindow.Maximized
    onWidthChanged: iworld.updatePosition()
    onHeightChanged: iworld.updatePosition()

    readonly property real animationDuration: 200
    property real pixelDensity: Screen.pixelDensity

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
        board: iworld.board
        onTimelineChanged: ifileManager.fileChanged()
    }
    SidePanelIconGallery{
        id: iiconGallery
    }
    SidePanelChartGallery{
        id: ichartGallery
    }
    ThemeGallery{
        id: ithemeGallery
    }
    Settings{
        id: isettings
    }
    SidePanel{
        id: isidePanel
    }

    FileManager{
        id: ifileManager

        appTitle: "Demon Presentation Board"
        application: iwin
        toFileFunc: function toFile(){
            var file = {
                "world":"",
                "timeline":"",
                "theme": ""
            }
            file.world = iworld.toJson()
            file.timeline = itimeline.toJson()
            file.theme = ithemeGallery.toJson()

            return JSON.stringify(file)
        }

        fromFileFunc: function fromFile(data){
            itimeline.clear()
            iworld.clear()
            var jsData = JSON.parse(data)
            iworld.fromJson(jsData.world)
            itimeline.fromJson(jsData.timeline)
            ithemeGallery.fromJson(jsData.theme)
        }

        binaryFilesFunc: function(){
            return iworld.binaryFiles()
        }

        fileFormat :"dpb"
    }
    RemoteHandler{
        id: iremoteHandler
    }
    Welcome{
        id: iwelcome
        visible: true
    }
    Shortcut {
        sequence: StandardKey.Cancel
        onActivated: {
            if(iwelcome.opened ||iiconGallery.opened ||
                    itimeline.opened ||
                    ithemeGallery.opened || isettings.opened){
                iwelcome.close()
                iiconGallery.close()
                ithemeGallery.close()
                isettings.close()
                itimeline.close()
            }else{
                iworld.currentElement = undefined
            }
        }
    }
}

