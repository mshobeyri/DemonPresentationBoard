import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import QtCharts 2.3
import ".."
import "SidePanelIconsJs.js" as JsModel

CustomDialog {
    id: iroot

    dialgTitle: "Chart Gallery"
    visible: false
    property alias chartType: ichartType.currentIndex
    property var currentChart: getChart(chartType)
    property rect area: Qt.rect(0,100,0,100)

    onCurrentChartChanged: {
        updateChart()
    }

    function getChart(chartType){
        switch (chartType){
        case ChartView.SeriesTypePie: return ipieChart
        case ChartView.SeriesTypeBar: return ibarChart
        case ChartView.SeriesTypeHorizontalBar: return ihorizontalBarChart
        case ChartView.SeriesTypePercentBar: return ipercentBarChart
        case ChartView.SeriesTypeHorizontalPercentBar: return ihorizontalPercentBarChart
        case ChartView.SeriesTypeStackedBar: return istackBarChart
        case ChartView.SeriesTypeHorizontalStackedBar: return ihorizontalStackBarChart
        case ChartView.SeriesTypeLine: return ilineChart
        case ChartView.SeriesTypeSpline: return isplineChart
        case ChartView.SeriesTypeArea: return iareaChart
        case ChartView.SeriesTypeScatter: return iscatterChart
        case ChartView.SeriesTypeBoxPlot: return iboxPlotChart
        case ChartView.SeriesTypeCandlestick: return icandleChart
        default: return ipieChart
        }
    }

    function toJsValues(valuesModel){

        return values
    }

    function updateChart(){
        ivalueAxis.max = 0
        ivalueAxis.min = 0
        ipropertyAxis.max = 0
        ipropertyAxis.min = 0
        currentChart.clear()
        currentChart.updateChart()
    }
    function updateAxis(){
        for(var i=0;i<iheadersModel.count;i++){
            ibarCategoryAxis.categories[i] = iheadersModel.get(i).value
            ihbarCategoryAxis.categories[i] = iheadersModel.get(i).value
            ipbarCategoryAxis.categories[i] = iheadersModel.get(i).value
            ihpbarCategoryAxis.categories[i] = iheadersModel.get(i).value
            ishbarCategoryAxis.categories[i] = iheadersModel.get(i).value
        }
    }

    ListModel{
        id: imodel

        ListElement{
            color: ""
            label: ""
            values: [
                ListElement{value:"0"}
            ]
        }
    }
    ListModel{
        id: iheadersModel
        ListElement{
            value:""
        }
    }

    BarCategoryAxis {
        id: ibarCategoryAxis
        categories: [""]
    }
    BarCategoryAxis {
        id: ihbarCategoryAxis
        categories: [""]
    }
    BarCategoryAxis {
        id: isbarCategoryAxis
        categories: [""]
    }
    BarCategoryAxis {
        id: ipbarCategoryAxis
        categories: [""]
    }
    BarCategoryAxis {
        id: ihpbarCategoryAxis
        categories: [""]
    }
    BarCategoryAxis {
        id: ishbarCategoryAxis
        categories: [""]
    }
    ValueAxis{
        id: ipropertyAxis
    }

    ValueAxis{
        id: ivalueAxis
    }

    Column{
        anchors.fill: parent
        RowLayout{
            Label{
                text: "Chart type"
            }
            ComboBox{
                id: ichartType

                Layout.preferredWidth: 400
                model: 13
                displayText: getChart(currentIndex).name
                delegate: MenuItem {
                    width: parent.width
                    text: getChart(index).name
                }
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
                    model: iheadersModel
                    delegate: Column{
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
                        TextField{
                            id: ititle
                            visible: chartType !== ChartView.SeriesTypePie
                            width: 100
                            onTextChanged: {
                                iheadersModel.get(index).value = text
                                updateAxis()
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
                        updateChart()
                    }
                }

                TextField{
                    width: 100
                    selectByMouse: true
                    placeholderText: "color"
                    text: model.color
                    onTextChanged: {
                        model.color = text
                    }
                }
                TextField{
                    width: 100
                    selectByMouse: true
                    placeholderText: "label"
                    text: model.label
                    onTextChanged: {
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
                            if(text!=="-")
                                parent.modelObj().values.get(index).value = text
                            updateChart()
                        }
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
                    iheadersModel.append({value:""})
                    updateAxis()
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
                    updateChart()
                }
            }
        }
        Item{
            height: 50
            width: 40
        }

        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypePie
            antialiasing: true
            PieSeries {
                id: ipieChart
                property string name: "Pie Chart"
                function updateChart(){
                    for(var i=0;i<imodel.count;i++){
                        ipieChart.append(imodel.get(i).label,Number(imodel.get(i).values.get(0).value))
                    }
                }
            }
        }

        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeBar
            antialiasing: true
            BarSeries{
                id: ibarChart

                axisX: ibarCategoryAxis
                property string name: "Bar Chart"
                function updateChart(){
                    axisY.max = 0
                    axisY.min = 0
                    for(var i=0;i<imodel.count;i++){
                        var values = []
                        for(var j=0;j< imodel.get(i).values.count;j++){
                            var value = Number(imodel.get(i).values.get(j).value)
                            values.push(value)
                            if(value < axisY.min)
                                axisY.min = value
                            if(value > axisY.max)
                                axisY.max = value
                        }
                        append(imodel.get(i).label,values)
                    }
                }
            }
        }
        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeHorizontalBar
            antialiasing: true
            HorizontalBarSeries{
                id: ihorizontalBarChart

                axisY: ihbarCategoryAxis
                property string name: "Horizontal Bar Chart"
                function updateChart(){
                    axisX.max = 0
                    axisX.min = 0

                    for(var i=0;i<imodel.count;i++){
                        var values = []
                        for(var j=0;j< imodel.get(i).values.count;j++){
                            var value = Number(imodel.get(i).values.get(j).value)
                            values.push(value)
                            if(value < axisX.min)
                                axisX.min = value
                            if(value > axisX.max)
                                axisX.max = value
                        }
                        append(imodel.get(i).label,values)
                    }
                }
            }
        }
        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypePercentBar
            antialiasing: true
            PercentBarSeries{
                id: ipercentBarChart
                axisX: ipbarCategoryAxis
                property string name: "Percent Bar Chart"
                function updateChart(){
                    for(var i=0;i<imodel.count;i++){
                        var values = []
                        for(var j=0;j< imodel.get(i).values.count;j++){
                            var value = Number(imodel.get(i).values.get(j).value)
                            values.push(value)
                        }
                        append(imodel.get(i).label,values)
                    }
                }
            }
        }
        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeHorizontalPercentBar
            antialiasing: true
            HorizontalPercentBarSeries{
                id: ihorizontalPercentBarChart
                axisY: ihpbarCategoryAxis
                property string name: "Horizontal Percent Bar Chart"
                function updateChart(){
                    for(var i=0;i<imodel.count;i++){
                        var values = []
                        for(var j=0;j< imodel.get(i).values.count;j++){
                            var value = Number(imodel.get(i).values.get(j).value)
                            values.push(value)
                        }
                        append(imodel.get(i).label,values)
                    }
                }
            }
        }
        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeStackedBar
            antialiasing: true
            StackedBarSeries{
                id: istackBarChart
                axisX: isbarCategoryAxis
                property string name: "Stack Bar Chart"

                function updateChart(){
                    axisY.max = 0
                    axisY.min = 0
                    for(var i=0;i<imodel.count;i++){
                        var values = []
                        for(var j=0;j< imodel.get(i).values.count;j++){
                            var value = Number(imodel.get(i).values.get(j).value)
                            values.push(value)
                            if(value < axisY.min)
                                axisY.min = value
                            if(value > axisY.max)
                                axisY.max = value
                        }
                        append(imodel.get(i).label,values)
                    }
                }
            }
        }

        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeHorizontalStackedBar
            antialiasing: true
            HorizontalStackedBarSeries{
                id: ihorizontalStackBarChart
                axisY: ishbarCategoryAxis
                property string name: "Horizontal Stack Bar Chart"
                function updateChart(){
                    axisX.max = 0
                    axisX.min = 0
                    for(var i=0;i<imodel.count;i++){
                        var values = []
                        for(var j=0;j< imodel.get(i).values.count;j++){
                            var value = Number(imodel.get(i).values.get(j).value)
                            values.push(value)
                            if(value < axisX.min)
                                axisX.min = value
                            if(value > axisX.max)
                                axisX.max = value
                        }
                        append(imodel.get(i).label,values)
                    }
                }
            }
        }

        ChartView{
            id: ilineChart

            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeLine
            antialiasing: true

            property string name: "Line Chart"

            function updateChart(){
                for(var i=0;i<imodel.count;i++){
                    var serie = createSeries(ChartView.SeriesTypeLine,imodel.get(i).label)
                    serie.axisX = ipropertyAxis
                    serie.axisY = ivalueAxis
                    for(var j=0;j<imodel.get(i).values.count;j++){
                        var x = Number(iheadersModel.get(j).value)
                        var y = Number(imodel.get(i).values.get(j).value)
                        serie.append(x,y)
                        if(x > ipropertyAxis.max)
                            ipropertyAxis.max = x
                        if(x < ipropertyAxis.min)
                            ipropertyAxis.min = x
                        if(y > ivalueAxis.max)
                            ivalueAxis.max= y
                        if(y < ivalueAxis.min)
                            ivalueAxis.min= y
                    }
                }
            }
            function clear(){
                removeAllSeries()
            }
        }

        ChartView{
            id: isplineChart

            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeSpline
            antialiasing: true

            property string name: "Spline Chart"

            function updateChart(){
                for(var i=0;i<imodel.count;i++){
                    var serie = createSeries(ChartView.SeriesTypeSpline,imodel.get(i).label)
                    serie.axisX = ipropertyAxis
                    serie.axisY = ivalueAxis
                    for(var j=0;j<imodel.get(i).values.count;j++){
                        var x = Number(iheadersModel.get(j).value)
                        var y = Number(imodel.get(i).values.get(j).value)
                        serie.append(x,y)
                        if(x > ipropertyAxis.max)
                            ipropertyAxis.max = x
                        if(x < ipropertyAxis.min)
                            ipropertyAxis.min = x
                        if(y > ivalueAxis.max)
                            ivalueAxis.max= y
                        if(y < ivalueAxis.min)
                            ivalueAxis.min= y
                    }
                }
            }
            function clear(){
                removeAllSeries()
            }
        }
        ChartView{
            id: iareaChart

            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeArea
            antialiasing: true

            property string name: "Area Chart"

            function updateChart(){
                for(var i=0;i<imodel.count;i++){
                    var serie = createSeries(ChartView.SeriesTypeArea,imodel.get(i).label)
                    serie.axisX = ipropertyAxis
                    serie.axisY = ivalueAxis
                    for(var j=0;j<imodel.get(i).values.count;j++){
                        var x = Number(iheadersModel.get(j).value)
                        var y = Number(imodel.get(i).values.get(j).value)
                        serie.upperSeries.append(x,y)
                        if(x > ipropertyAxis.max)
                            ipropertyAxis.max = x
                        if(x < ipropertyAxis.min)
                            ipropertyAxis.min = x
                        if(y > ivalueAxis.max)
                            ivalueAxis.max= y
                        if(y < ivalueAxis.min)
                            ivalueAxis.min= y
                    }
                }
            }
            function clear(){
                removeAllSeries()
            }
        }
        ChartView{
            id: iscatterChart

            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeScatter
            antialiasing: true

            property string name: "Scatter Chart"

            function updateChart(){
                for(var i=0;i<imodel.count;i++){
                    var serie = createSeries(ChartView.SeriesTypeScatter,imodel.get(i).label)
                    serie.axisX = ipropertyAxis
                    serie.axisY = ivalueAxis
                    for(var j=0;j<imodel.get(i).values.count;j++){
                        var x = Number(iheadersModel.get(j).value)
                        var y = Number(imodel.get(i).values.get(j).value)
                        serie.append(x,y)
                        if(x > ipropertyAxis.max)
                            ipropertyAxis.max = x
                        if(x < ipropertyAxis.min)
                            ipropertyAxis.min = x
                        if(y > ivalueAxis.max)
                            ivalueAxis.max= y
                        if(y < ivalueAxis.min)
                            ivalueAxis.min= y
                    }
                }
            }
            function clear(){
                removeAllSeries()
            }
        }

        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeBoxPlot
            antialiasing: true
            BoxPlotSeries{
                id: iboxPlotChart
                property string name: "Box Plot Chart"
                function updateChart(){
                    for(var i=0;i<imodel.count;i++){

                    }
                }
            }
        }
        ChartView{
            width: 400
            height: 400
            theme: ChartView.ChartThemeHighContrast
            visible: chartType === ChartView.SeriesTypeCandlestick
            antialiasing: true
            CandlestickSeries{
                id: icandleChart
                property string name: "Candle Stick Chart"
                function updateChart(){
                    for(var i=0;i<imodel.count;i++){

                    }
                }
            }
        }
    }
}
