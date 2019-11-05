import QtQuick 2.12
import QtQuick.Controls 2.5 as QQ2
import Qt.labs.platform 1.0
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.3

Item {
    id : iroot

    anchors.fill: parent

    property var application: undefined
    property var toFileFunc:undefined
    property var fromFileFunc:undefined
    property int openRecentsCount: 20
    property var nameFilters

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
        if(!iprv.doesForgotToSave(function(){iopenFileDialog.open()})){
            iopenFileDialog.open()
        }
    }

    function fileChanged(){
        isFileChanged = true
    }

    Component.onCompleted: iprv.appName = application.title
    Item{
        id: iprv

        property string appName

        property string appTitle: {
            var str = appName
            if(currentFileName!=="")
                str+=" - "+currentFileName
            if(isFileChanged)
                str+="*"
            str
        }

        onAppTitleChanged: {
            application.title = appTitle
        }

        function saveAccepted(path){
            newFile(path)
            save()
        }
        function openAccepted(path){
            newFile(path)
        }
        function save(){
            var data = toFileFunc()
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
                    openRecents.remove(i)
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
                openRecents.remove(0)
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
                onClicked:  iforgotToSaveDialog.discartFunc()
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
        nameFilters: iroot.nameFilters
        onAccepted: iprv.saveAccepted(isaveFileDialog.currentFile)
    }

    FileDialog{
        id: iopenFileDialog

        fileMode: FileDialog.OpenFile
        nameFilters: iroot.nameFilters
        onAccepted: iprv.openAccepted(iopenFileDialog.currentFile)
    }
}
