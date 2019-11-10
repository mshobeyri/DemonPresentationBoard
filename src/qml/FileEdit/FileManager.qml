import QtQuick 2.12
import QtQuick.Controls 2.5 as QQ2
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import Qt.labs.settings 1.0
import "../qmlHelper.js" as Qmlhelper

Item {
    id : iroot

    anchors.fill: parent

    property var application: undefined
    property var toFileFunc:undefined
    property var fromFileFunc:undefined
    property int openRecentsCount: 20
    property string fileFormat

    property alias openRecentModel: iopenRecentModel

    property string currentFilePath: ""
    property string currentFileName: ""
    property bool isFileChanged: false
    property string appTitle

    function saveBtnTriggered(){
        if(currentFilePath==="")
            saveAsBtnTriggered()
        else
            iprv.save()
    }

    function saveAsBtnTriggered(){
        isaveFileDialog.open()
    }

    function openBtnTriggered(){
        iopenFileDialog.open()
    }

    function fileChanged(){
        isFileChanged = true
        iundoRedo.grab()
    }
    function open(path){
        iundoRedo.clear()
        fromFileFunc(fileio.read(path))
        iundoRedo.grab()
    }

    Component.onCompleted:  {
        if(isettings.openRecentsStr === "")
            return
        var openRecentJs = JSON.parse(isettings.openRecentsStr)
        for(var i = 0;i < openRecentJs.length;i++)
            openRecentModel.append({
                                       "title": openRecentJs[i].title,
                                       "subtitle": openRecentJs[i].subtitle
                                   })

    }
    Component.onDestruction: {
        var modelJs = []
        for(var i = 0;i < openRecentModel.count;i++)
            modelJs.push({
                             "title": openRecentModel.get(i).title,
                             "subtitle": openRecentModel.get(i).subtitle
                         })
        isettings.openRecentsStr = JSON.stringify(modelJs)
    }

    ListModel{
        id: iopenRecentModel
    }

    Settings{
        id: isettings
        property string openRecentsStr
    }

    UndoRedo{
        id: iundoRedo
    }

    Item{
        id: iprv

        readonly property var nameFilters:
            [iprv.appTitle+" Files (*."+fileFormat+")",
            "All files (*.*)"]

        property string appTitle: {
            var str = iroot.appTitle
            if(currentFileName!=="")
                str+=" - "+currentFileName
            if(isFileChanged)
                str+="*"
            str
        }

        onAppTitleChanged: {
            application.title = appTitle
        }
        function openAccepted(path){
            open(path)
            newFile(path)
        }
        function saveAccepted(path){
            path = path.toString()
            if(Qmlhelper.fileFormatFromPath(path)!==fileFormat)
                path = path + "."+fileFormat
            newFile(path)
            save()
        }


        function save(){
            var data = toFileFunc()
            fileio.write(currentFilePath,data)
            isFileChanged = false
        }

        function closeBtnTriggered(close){
            close.accepted = false
            if(!iprv.doesForgotToSave(function(){Qt.quit()})){
                close.accepted = true
            }
        }

        function newFile(path){
            currentFilePath = fileio.toLocalFile(path)
            for(var i=0;i<openRecentModel.count;i++){
                if(openRecentModel.get(i).subtitle === currentFilePath){
                    openRecentModel.remove(i)
                }
            }
            currentFileName = currentFilePath.substring(
                        currentFilePath.lastIndexOf("/")+1,
                        currentFilePath.length)
            isFileChanged = false
            openRecentModel.insert(0,{
                                       "title": currentFileName,
                                       "subtitle": currentFilePath
                                   })
            while (openRecentModel.count > openRecentsCount)
                openRecentModel.remove(0)
        }

        function doesForgotToSave(func){
            if(!isFileChanged)
                return false
            iforgotToSaveDialog.setOnDiscartAndOpen(func)
            return true
        }
    }

    Connections{
        target: application
        onClosing: iprv.closeBtnTriggered(close)
    }

    Shortcut {
        sequence: StandardKey.Save
        onActivated: {
            saveBtnTriggered()
        }
    }

    Shortcut {
        sequence: StandardKey.SaveAs
        onActivated: {
            saveAsBtnTriggered()
        }
    }

    Shortcut {
        sequence: StandardKey.Open
        onActivated: {
            openBtnTriggered()
        }
    }

    QQ2.Dialog{
        id: iforgotToSaveDialog

        title: "Save changes before closing?"
        anchors.centerIn: parent
        closePolicy: QQ2.Dialog.NoAutoClose
        property var discartFunc: undefined

        function setOnDiscartAndOpen(func){
            discartFunc = func
            open()
        }
        QQ2.Label{
            text: "If you close without saving,"
                  +" your changes will be discarded."
        }
        footer: RowLayout{
            Item{
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            QQ2.Button{
                flat: true
                text: "Close widhtout saving"
                onClicked:  {
                    iforgotToSaveDialog.discartFunc()
                    iforgotToSaveDialog.close()
                }
                Material.foreground: Material.accent
            }
            QQ2.Button{
                flat: true
                text: "Cancel"
                onClicked: iforgotToSaveDialog.close()
                Material.foreground: Material.accent
            }
            QQ2.Button{
                text: "Save"
                onClicked: saveBtnTriggered()
                Layout.rightMargin: 10
                Material.background: Material.accent
            }
        }
    }

    FileDialog{
        id: isaveFileDialog

        fileMode: FileDialog.SaveFile
        nameFilters: iprv.nameFilters
        onAccepted: iprv.saveAccepted(isaveFileDialog.currentFile)
        defaultSuffix:  fileFormat
    }

    FileDialog{
        id: iopenFileDialog

        fileMode: FileDialog.OpenFile
        nameFilters: iprv.nameFilters
        onAccepted: iprv.openAccepted(iopenFileDialog.currentFile)
    }
}
