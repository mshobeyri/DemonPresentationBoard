import QtQuick 2.12
import QtQuick.Controls 2.5
import QtCharts 2.3

Column{
    property alias table: itable
    function updateHeaders(){
        table.headerItem.headersRepeater.model = []
        table.headerItem.headersRepeater.model = iheadersModel
    }

    width: parent.width - 100
    Row {
        width: parent.width
        ListView{
            id: itable

            model: imodel
            width: contentWidth >parent.width?
                       parent.width :contentWidth
            height: interactive?contentHeight + iscorllBar.height:contentHeight
            currentIndex: 0
            contentWidth: currentItem===null?0:currentItem.width
            contentHeight: currentItem===null?0:currentItem.height*imodel.count
            flickableDirection: Flickable.HorizontalFlick
            clip: true
            interactive: contentWidth > width

            ScrollBar.horizontal: ScrollBar {
                id: iscorllBar
                anchors.bottom: parent.bottom
                width: parent.width
            }

            Behavior on contentWidth {
                NumberAnimation{duration: 100}
            }

            Behavior on height {
                NumberAnimation{duration: 100}
            }

            header: Row{
                property alias headersRepeater: iheadersRepeater
                leftPadding: 150
                Repeater{
                    id: iheadersRepeater
                    model: iheadersModel
                    delegate: Column{
                        Button{
                            font.family: ifontAwsome.name
                            text: "trash-alt"
                            flat: true
                            width: 100
                            enabled: iheadersModel.count > 1
                            opacity: enabled?hovered?1:0.1:0
                            onClicked: {
                                for(var i=imodel.count-1;i>=0;i--){
                                    imodel.get(i).values.remove(index)
                                }
                                iheadersModel.remove(index)
                                updateChart()
                            }
                        }
                        TextField{
                            width: 100
                            selectByMouse: true
                            text: model.value
                            placeholderText: "range"
                            onTextChanged: {
                                if(!focus) return
                                iheadersModel.get(index).value = text
                                updateChart()
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
                    opacity: enabled?hovered?1:0.1:0
                    onClicked: {
                        imodel.remove(index)
                        updateChart()
                    }
                }

                TextField{
                    width: 100
                    selectByMouse: true
                    placeholderText: "label"
                    text: model.label
                    onTextChanged: {
                        if(!focus) return
                        model.label = text
                        updateChart()
                    }
                }
                Repeater{
                    model: parent.modelObj().values
                    TextField{
                        width: 100
                        selectByMouse: true
                        placeholderText: "value"
                        text: model.value!==undefined?model.value:""
                        onTextChanged: {
                            if(!focus) return
                            if(text!=="-")//todo
                                parent.modelObj().values.get(index).value = text
                            updateChart()
                        }
                    }
                }
            }
        }
        Button{
            y: 50
            width: 50
            height: itable.height - 50
            flat: true
            font.family: ifontAwsome.name
            text: "plus"
            leftInset: 6
            rightInset: 6
            topInset: 0
            bottomInset: 0
            onClicked: {
                var c = imodel.get(0).values.count
                for(var i=0;i<imodel.count;i++){
                    imodel.get(i).values.insert(c,{value:""})
                }
                iheadersModel.append({value:""})
                updateChart()
                itable.flick(itable.interactive?-itable.contentWidth:0,0)
            }
        }
    }
    Button{
        flat: true
        font.family: ifontAwsome.name
        text: "plus"
        width: itable.width - 50
        x: 50
        onClicked: {
            var values = [];
            for(var i=0;i<imodel.get(0).values.count;i++){
                values.push({value:""})
            }

            imodel.insert(imodel.count,{color:"",label:"",values:values})
            updateChart()
        }
    }
}
