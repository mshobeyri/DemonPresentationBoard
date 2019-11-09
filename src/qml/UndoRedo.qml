import QtQuick 2.12

Item {
    property var history: []
    property int currentIndex: -1
    function grab(){
        history.splice(currentIndex+1,
                       history.length - currentIndex,
                       ifileManager.toFileFunc())
        currentIndex ++
    }

    function undo(){
        if(currentIndex <= 0)
            return
        currentIndex --
        ifileManager.fromFileFunc(history[currentIndex])
    }
    function redo(){
        if(currentIndex+1 >= history.length)
            return
        currentIndex ++
        ifileManager.fromFileFunc(history[currentIndex])
    }
    function clear(){
        while(history.length > 0)
            history.pop()
        currentIndex = -1
        isFileChanged = false
    }
    Shortcut{
        sequence: StandardKey.Undo
        onActivated: undo()
    }
    Shortcut{
        sequence: StandardKey.Redo
        onActivated: redo()
    }
    Component.onCompleted: {
        clear()
        grab()
    }
}
