import QtQuick 2.12

Item {
    function toFile(){
        var file = {
            "world":"",
            "timeline":""
        }
        file.world = iworld.toJson()
        file.timeline = itimeline.toJson()

        console.log(JSON.stringify(file))
    }

    Shortcut {
        sequence: StandardKey.Save
        onActivated: {
            toFile()
        }
    }
}
