import QtQuick 2.12

Item {
    property var history: []
    property int currentIndex: -1
    function grabAll(){
        var data = {
            "obj": "all",
            "js": ifileManager.toFileFunc()
        }
        history.splice(currentIndex+1,
                       history.length - currentIndex,
                       data)
        currentIndex ++
    }
    function grabChanges(object, json){
        var data = {
            "obj": object,
            "js": json
        }
        history.splice(currentIndex+1,
                       history.length - currentIndex,
                       data)
        currentIndex ++
    }
    function handle(){
        var data = history[currentIndex]
        if(data.obj === "all"){
            ifileManager.fromFile(data.js)
        }else{
            data.obj.fromJson(data.js)
        }
    }
    function undo(){
        if(currentIndex <= 0)
            return
        currentIndex --
        handle()
    }
    function redo(){
        if(currentIndex+1 >= history.length)
            return
        currentIndex ++
        handle()
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
        grabAll()
    }
}
