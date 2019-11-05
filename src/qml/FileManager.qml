import QtQuick 2.12
import QtQuick.Controls 2.5 as QQ2
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3
import Qt.labs.settings 1.0

Item {
    id : iroot

    anchors.fill: parent

    property var application: undefined
    property var toFileFunc:undefined
    property var fromFileFunc:undefined
    property int openRecentsCount: 20
    property string fileFormat

    property var openRecents: []
    property string currentFilePath: ""
    property string currentFileName: ""
    property bool isFileChanged: false

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
    }

    Settings{
        property alias openRecents: iroot.openRecents
    }

    Item{
        id: iprv

        property string appName
        readonly property var nameFilters:
            [iprv.appName+" Files (*."+fileFormat+")",
            "All files (*.*)"]

        property string appTitle: {
            var str = appName
            if(currentFileName!=="")
                str+=" - "+currentFileName
            if(isFileChanged)
                str+="*"
            str
        }

        Component.onCompleted: appName = application.title

        onAppTitleChanged: {
            application.title = appTitle
        }
        function openAccepted(path){
            open(path)
            newFile(path)
        }
        function saveAccepted(path){
            path = path.toString()
            if(path.substring(
                        path.lastIndexOf(".")+1,
                        path.length)!==fileFormat)
            path = path + "."+fileFormat
            newFile(path)
            save()
        }
        function open(path){
            fromFileFunc(fileio.read(path))
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
            currentFilePath = path
            for(var i=0;i<openRecents.length;i++){
                if(openRecents[i].path === currentFilePath){
                    openRecents.splice(i,1)
                }
            }
            currentFileName = currentFilePath.substring(
                        currentFilePath.lastIndexOf("/")+1,
                        currentFilePath.length)
            isFileChanged = false
            openRecents.push({
                                 "name": currentFileName,
                                 "path": currentFilePath
                             })
            while (openRecents.length > openRecentsCount)
                openRecents.splice(0,1)
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
