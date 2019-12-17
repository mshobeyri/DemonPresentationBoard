import QtQuick 2.12
import Qt.labs.platform 1.1
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer
    baseHeight: 90
    property var sourceSize
    property string tempName: ""
    property string source: ""
    property bool isAnimated: icontainer.source.indexOf(".gif")===icontainer.source.length-4
    property bool isVector: icontainer.source.indexOf(".svg")===icontainer.source.length-4
    property var json: {
        "type":Element.image,
        "common": icontainer.commonData,
        "tempName": icontainer.tempName
    }

    function fromJson(json){
        source = fileio.tempFolderFileUrl(json.tempName)
    }
    function handleFile(path){
        icontainer.tempName = fileio.copyToTempFolder(path)
        icontainer.source = fileio.tempFolderFileUrl(tempName)
        icontainer.elementChanged()
        w = h * (sourceSize.width/sourceSize.height)
    }

    onCreated: {
        if(icontainer.source == "")
            isourceSelector.open()
    }

    FileDialog{
        id: isourceSelector
        nameFilters: ["Image files (*.jpg *.jpeg *.png *.svg *.gif)", "All files (*.*)"]
        onAccepted: {
            handleFile(currentFile)
        }
        onRejected: icontainer.deleteIt()
    }

    component:  Component {
        Item{
            Image{
                anchors.fill: parent
                source: visible&& tempName!=="" ?icontainer.source:""
                visible: icontainer.isVector
                antialiasing: true
                sourceSize: Qt.size(width,height)
                onSourceChanged: {
                    icontainer.sourceSize = sourceSize
                }
            }

            Image {
                anchors.fill: parent
                source: visible&& tempName!=="" ?icontainer.source:""
                visible: !icontainer.isVector && !icontainer.isAnimated
                antialiasing: true
                onSourceChanged: {
                    icontainer.sourceSize = sourceSize
                }
            }

            AnimatedImage{
                anchors.fill: parent
                source:visible&& tempName!=="" ?icontainer.source:""
                visible: icontainer.isAnimated
                antialiasing: true
                onSourceChanged: {
                    icontainer.sourceSize = sourceSize
                }
            }
        }
    }
}
