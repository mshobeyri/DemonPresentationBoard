import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Menu {
    Menu{
        title: "File"

        MenuItem{
            text: "Open"
        }
        MenuItem{
            text: "Save"
        }
        MenuItem{
            text: "SaveAs"
        }
    }
    Menu{
        title: "Edit"

        MenuItem{
            text: "Cut"
            shortcut: StandardKey.cut
            onTriggered: {

                if(iworld.currentElement!==null &&
                        iworld.currentElement!== undefined){
                    iworld.currentElement.destroy()
                    fileio.copyToClipboard(iworld.currentElement.json)
                }
            }
        }
        MenuItem{
            text: "Copy"
            shortcut: StandardKey.Copy
            onTriggered: {
                if(iworld.currentElement!==null &&
                        iworld.currentElement!== undefined)
                    fileio.copyToClipboard(iworld.currentElement.json)
            }
        }
        MenuItem{
            text: "Paste"
            shortcut: StandardKey.Paste
            onTriggered: {
                var txt = fileio.getClipboard()
                try {
                    var js = JSON.parse(txt)
                    iworld.createElement(js.type,js)
                }catch(err){

                }
            }
        }
    }
    MenuSeparator{}
    MenuItem{
        text: "Remote"
    }
    MenuSeparator{}
    MenuItem{
        text: "Settings"
        onClicked: isettings.open()
    }
}
