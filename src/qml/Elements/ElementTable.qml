import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property int rows: 3
    property int cols: 2
    property int lastRowsCount: 3
    property int lastColumnsCount: 2
    property string sepratorsColor: "border"
    property string backgroundColor: "primary"
    property string textColor: "foreground"
    property int spacing: 4
    property font textFont
    property int textJustify: TextEdit.AlignLeft
    property var listmodel: ["text","text","text","text","text","text"]

    property var json: {
        "type":Element.table,
        "common": icontainer.commonData,
        "cols": icontainer.cols,
        "rows": icontainer.rows,
        "sepratorsColor": icontainer.sepratorsColor.toString(),
        "backgroundColor": icontainer.backgroundColor.toString(),
        "textColor": icontainer.textColor.toString(),
        "spacing": icontainer.spacing,
        "textFont": icontainer.textFont,
        "textJustify": icontainer.textJustify,
        "listmodel":icontainer.listmodel
    }

    function fromJson(json){
        cols =  json.cols
        rows = json.rows
        sepratorsColor = json.sepratorsColor
        backgroundColor = json.backgroundColor
        textColor = json.textColor
        spacing = json.spacing
        textJustify = json.textJustify
        textFont.family = json.textFont.family
        textFont.bold = json.textFont.bold
        textFont.italic = json.textFont.italic
        textFont.pointSize = json.textFont.pointSize
        listmodel = json.listmodel
    }

    function updateRepeater(){
        if(loader.item!==null)
            loader.item.repeater.model = listmodel
    }
    onCreated: {
        textFont.pointSize = Math.floor(h / pixelDensity / 2.9)
    }

    onRowsChanged: {
        if(rows > lastRowsCount){
            for(var i=0;i< cols * (rows - lastRowsCount);i++)
                listmodel.push("text")
        }else{
            for(i=0;i < cols * (lastRowsCount - rows);i++)listmodel.pop()
        }
        updateRepeater()
        lastRowsCount = rows
    }
    onColsChanged: {
        if(cols > lastColumnsCount){
            for(var i=1; i<=rows;i++){
                listmodel.splice( i *cols -1 ,0,"text")
            }
        }else{
            for(i=rows; i>=1;i--){
                listmodel.splice( i *lastColumnsCount -1 ,1)
            }
        }
        updateRepeater()

        lastColumnsCount = cols
    }

    onDoubleClicked:{
        editMode = true
        currentElement = icontainer
    }
    onSelectedChanged: {
        if(!selected)
            editMode = false
    }

    component:  Component {
        Rectangle{
            id: irect

            color: ithemeGallery.themeColor(sepratorsColor)
            clip: true
            antialiasing: true

            property alias repeater : irepeater
            Grid{
                id: igrid

                antialiasing: true
                anchors{
                    fill: parent
                    margins: icontainer.spacing
                    rightMargin: 0
                    bottomMargin: 0
                }
                rows: icontainer.rows
                columns: icontainer.cols
                spacing: icontainer.spacing
                Repeater{
                    id: irepeater

                    model: listmodel
                    Item{
                        width: (igrid.width/icontainer.cols)-icontainer.spacing
                        height: (igrid.height/icontainer.rows)-icontainer.spacing
                        Rectangle{
                            anchors.fill: parent
                            color: ithemeGallery.themeColor(icontainer.backgroundColor)
                            anchors.centerIn: parent
                            antialiasing: true
                            TextEdit {
                                anchors.fill: parent
                                antialiasing: true
                                anchors.margins: icontainer.spacing
                                color: ithemeGallery.themeColor(icontainer.textColor)
                                enabled: editMode
                                text: modelData
                                onTextChanged: listmodel.splice(model.index,1,text)
                                font: icontainer.textFont
                                wrapMode: TextEdit.WordWrap
                                horizontalAlignment: textJustify
                                verticalAlignment: TextEdit.AlignVCenter
                            }
                        }
                    }
                }
            }
        }
    }
}
