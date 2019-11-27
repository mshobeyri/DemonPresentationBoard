import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import "../Elements/ElementHelper.js" as Eelements

Menu {

    function cut(){
        if(iworld.currentElement!==null &&
                iworld.currentElement!== undefined){
            iworld.currentElement.destroy()
            fileio.copyToClipboard(JSON.stringify(iworld.currentElement.json))
        }
    }

    function copy(){
        if(iworld.currentElement!==null &&
                iworld.currentElement!== undefined)
            fileio.copyToClipboard(JSON.stringify(iworld.currentElement.json))
    }

    function paste(){
        var txt = fileio.getClipboard()
        try {
            var js = JSON.parse(txt)
            if(js.type!==undefined)
                iworld.createElement(js.type,js)
            else
                pasteText(txt)
        }catch(err){
            pasteText(txt)
        }
    }
    function pasteText(txt){
        var sc = iworld.board.sceneCenter()
        iworld.createElement(Eelements.text,{text:txt,x:sc.x,y:sc.y,rotation:-iworld.board.rotation})
    }

    Shortcut{
        sequence: StandardKey.Cut
        onActivated: cut()
    }
    Shortcut{
        sequence: StandardKey.Copy
        onActivated: copy()
    }
    Shortcut{
        sequence: StandardKey.Paste
        onActivated: paste()
    }

    MenuItem{
        text: "Welcome"
        onTriggered: iwelcome.open()
    }

    MenuSeparator{}
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
            onTriggered: cut()
        }
        MenuItem{
            text: "Copy"
            onTriggered: copy()
        }
        MenuItem{
            text: "Paste"
            onTriggered: paste()
        }
    }

    MenuSeparator{}
    MenuItem{
        text: "Settings"
        onClicked: isettings.open()
    }
    MenuSeparator{}
    MenuItem{
        text: iwin.visibility === ApplicationWindow.FullScreen?
                  "Normal":"Fullscreen"
        onClicked: {
            iwin.visibility === ApplicationWindow.FullScreen?
                        iwin.visibility = ApplicationWindow.Maximized:
                        iwin.visibility = ApplicationWindow.FullScreen
        }
    }
}
