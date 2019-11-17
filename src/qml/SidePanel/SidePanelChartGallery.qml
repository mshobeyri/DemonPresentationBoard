import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."
import "SidePanelIconsJs.js" as JsModel

CustomDialog {
    id: iroot

    dialgTitle: "Chart Gallery"
    visible: false

    ListModel{
        id: imodel
        ListElement{
            color: "red"
            label: "salam"
            values: [
                ListElement{value:10},
                ListElement{value:10},
                ListElement{value:10}
            ]
        }

    }
    Column{
        anchors.fill: parent
        RowLayout{
            Label{
                text: "Chart type"
            }
            ComboBox{
                id: isearchFields
                Layout.preferredWidth: 200
                model: ["Pie Chart", "Bar Chart", "Line Chart","Stack Chart","Candle Chart"]
            }
            IconButton{
                iconStr: "trash-alt"
                text: "delete row"
            }
            IconButton{
                iconStr: "trash-alt"
                text: "delete column"
            }
        }
        ListView{
            id: ipieChartListView

            model: imodel
            width: contentWidth
            height: contentHeight
            contentWidth: currentItem===null?0:currentItem.width
            contentHeight: currentItem===null?0:currentItem.height*imodel.count
            currentIndex: 0
            Behavior on contentWidth {
                NumberAnimation{duration: 100}
            }

            Behavior on height {
                NumberAnimation{duration: 100}
            }

            header: Row{
                leftPadding: 250
                Repeater{
                    model: imodel.get(0).values.count
                    Button{
                        font.family: ifontAwsome.name
                        text: "trash-alt"
                        flat: true
                        width: 100
                        enabled: imodel.get(0).values.count > 1
                        opacity: hovered?1:0
                        onClicked: {
                            for(var i=imodel.count-1;i>=0;i--){
                                imodel.get(i).values.remove(index)
                            }
                        }
                    }
                }
            }

            delegate: Row{
                function modelObj(){
                    return model
                }
                ToolButton{
                    font.family: ifontAwsome.name
                    text: "trash-alt"
                    enabled: imodel.count > 1
                    opacity: hovered?1:0
                    onClicked: {
                        imodel.remove(index)
                    }
                }

                TextField{
                    width: 100
                    selectByMouse: true
                    placeholderText: "color"
                    text: model.color
                }
                TextField{
                    width: 100
                    selectByMouse: true
                    placeholderText: "label"
                    text: model.label
                }
                Repeater{
                    model: parent.modelObj().values
                    TextField{
                        width: 100
                        selectByMouse: true
                        placeholderText: "value"
                        text: value
                    }
                }
            }

            Button{
                flat: true
                font.family: ifontAwsome.name
                text: "plus"
                width: 50
                height: ipieChartListView.height - 50
                anchors.left: parent.right
                anchors.bottom: parent.bottom
                leftInset: 6
                rightInset: 6
                topInset: 0
                bottomInset: 0
                onClicked: {
                    var c = imodel.get(0).values.count
                    for(var i=0;i<imodel.count;i++){
                        imodel.get(i).values.insert(c,{value:0})
                    }
                }
            }
            Button{
                flat: true
                font.family: ifontAwsome.name
                text: "plus"
                width: ipieChartListView.width - 50
                anchors.top: parent.bottom
                anchors.right: parent.right
                onClicked: {
                    var values = [];
                    for(var i=0;i<imodel.get(0).values.count;i++){
                        values.push(0)
                    }

                    imodel.insert(imodel.count,{color:"",label:"",values:values})
                }
            }
        }
    }
}
