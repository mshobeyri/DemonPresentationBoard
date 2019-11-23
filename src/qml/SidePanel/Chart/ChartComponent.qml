import QtQuick 2.12
import QtCharts 2.3

Column{
    property int chartType: 1
    property int currentTheme
    property bool containLegend
    property var currentChart: getChart(chartType)

    property int valueForm:0
    property int valueTo:100
    property int valueTick:5
    property int rangeForm:0
    property int rangeTo:100
    property int rangeTick:5
    property alias dataModel: imodel
    property alias headersModel: iheadersModel

    onCurrentChartChanged: {
        updateChart()
    }
    onCurrentThemeChanged: {
        updateChart()
    }
    onContainLegendChanged: {
        updateChart()
    }

    function updateChart(){
        currentChart.clear()
        currentChart.updateAxis()
        currentChart.updateChart()
    }

    ListModel{
        id: imodel

        ListElement{
            color: ""
            label: ""
            values: [
                ListElement{value: ""}
            ]
        }
    }

    ListModel{
        id: iheadersModel

        ListElement{
            value:""
        }
    }

    function toJson(){
        var headers = []
        for(var i=0;i<iheadersModel.count;i++)
            headers.push(iheadersModel.get(i).value.toString())

        var data = []
        for(i=0;i<imodel.count;i++){

            var rowValues = [];
            for(var j=0;j<imodel.get(i).values.count;j++){
                rowValues.push(imodel.get(i).values.get(j).value)
            }

            var row ={
                "label": imodel.get(i).label,
                "values": rowValues
            }

            data.push(row)
        }

        var axises= {
            "range":{
                "from": rangeForm,
                "to": rangeTo,
                "tick": rangeTick
            },
            "value":{
                "from": valueForm,
                "to": valueTo,
                "tick": valueTick
            }
        }

        var options = {
            "legend": containLegend,
            "theme": currentTheme
        }

        var json = {
            "type": chartType,
            "headers":headers,
            "data":data,
            "axises": axises,
            "options": options
        }
        return json
    }

    function fromJson(json){
        iheadersModel.clear()
        imodel.clear()
//        clear()

        chartType = json.type

        for(var i=0;i<json.headers.length;i++){
            iheadersModel.append({value:json.headers[i].toString()})
        }

        for(i=0;i<json.data.length;i++){
            imodel.append({label:json.data[i].label,values:[]})

            for(var j=0;j<json.data[i].values.length;j++){
                imodel.get(i).values.append({value:json.data[i].values[j].toString()})
            }
        }

        rangeForm = json.axises.range.from
        rangeTo = json.axises.range.to
        rangeTick = json.axises.range.tick
        valueForm = json.axises.value.from
        valueTo = json.axises.value.to
        valueTick = json.axises.value.tick

        containLegend = json.options.legend
        currentTheme = json.options.theme
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
        default: return ipieChart
        }
    }

    ChartPie{
        id: ipieChart
    }
    ChartBar{
        id: ibarChart
    }
    ChartBarHorizontal{
        id: ihorizontalBarChart
    }
    ChartBarPercent{
        id: ipercentBarChart
    }
    ChartBarPercentHorizontal{
        id: ihorizontalPercentBarChart
    }
    ChartBarStacked{
        id: istackBarChart
    }
    ChartBarStackedHorizontal{
        id: ihorizontalStackBarChart
    }
    ChartBaseXY{
        id: ilineChart
        type: ChartView.SeriesTypeLine
    }
    ChartBaseXY{
        id: isplineChart
        type: ChartView.SeriesTypeSpline
    }
    ChartBaseXY{
        id: iareaChart
        type: ChartView.SeriesTypeArea
    }
    ChartBaseXY{
        id: iscatterChart
        type: ChartView.SeriesTypeScatter
    }
}
