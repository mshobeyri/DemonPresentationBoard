import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."
import "SidePanelIconsJs.js" as JsModel

CustomDialog {
    id: iroot

    dialgTitle: "Icon Gallery"
    Component.onCompleted: {
        for(var i= 0;i<JsModel.icons.length;i++){
            for(var j= 0;j<JsModel.icons[i].icons.length;j++){
                imodel.append({ "category":JsModel.icons[i].label,
                                "name":JsModel.icons[i].icons[j],
                                  "bold":true
                              })
            }
        }
    }
    ListModel{
        id: imodel
    }

    GridView{
        id: igrid

        anchors.fill: parent
        model: imodel
        clip: true
        cellHeight: 40
        cellWidth:40

        delegate: ToolButton{
            text: model.name
            flat: true
            font.family: ifontAwsome.name
            font.bold: model.bold
        }
    }
}
