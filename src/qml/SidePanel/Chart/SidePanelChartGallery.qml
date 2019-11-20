import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import QtCharts 2.3
import ".."
import "../.."

CustomDialog {
    id: ichartGallery

    dialgTitle: "Chart Gallery"
    visible: false
    property alias chartType: ichartType.currentIndex
    property var currentChart: getChart(chartType)
    property rect area: Qt.rect(0,100,0,100)

    property alias valueForm: ivalueForm.value
    property alias valueTo: ivalueTo.value
    property alias valueTick: ivalueTick.value
    property alias rangeForm: irangeForm.value
    property alias rangeTo: irangeTo.value
    property alias rangeTick: irangeTick.value

    onCurrentChartChanged: {
        updateChart()
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
            "legend": ilegendCheck.checked,
            "theme": itheme.currentIndex
        }

        var json = {
            "type": ichartType.currentIndex,
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

        ichartType.currentIndex = json.type

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

        ilegendCheck.checked = json.options.legend
        itheme.currentIndex = json.options.theme

        ichartTable.updateHeaders()
    }

    Button{
        anchors.centerIn: parent
        onClicked: {
            fromJson(toJson())
        }
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
    function chartName(type){
        switch (type){
        case ChartView.SeriesTypePie: return "Pie Chart"
        case ChartView.SeriesTypeBar: return "Bar Chart"
        case ChartView.SeriesTypeHorizontalBar: return "Horizontal Bar Chart"
        case ChartView.SeriesTypePercentBar: return "Percent Bar Chart"
        case ChartView.SeriesTypeHorizontalPercentBar: return "Horizontal Percent Bar Chart"
        case ChartView.SeriesTypeStackedBar: return "Stacked Bar Chart"
        case ChartView.SeriesTypeHorizontalStackedBar: return "Stacked Horizontal Bar Chart"
        case ChartView.SeriesTypeLine: return "Line Chart"
        case ChartView.SeriesTypeSpline: return "Spline Chart"
        case ChartView.SeriesTypeArea: return "Area Chart"
        case ChartView.SeriesTypeScatter: return "Scatter Chart"
        default: return "Unknown"
        }
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
    Flickable{
        contentHeight: icolumn.height
        interactive: height < contentHeight || width < contentWidth
        anchors.fill: parent
        clip: true
        Column{
            id: icolumn
            width: parent.width
            Grid{
                width: parent.width
                columns: ichartGallery.width > 900? 2:1
                spacing: 40
                GridLayout{
                    columns: 2

                    Label{
                        text: "type"
                    }
                    ComboBox{
                        id: ichartType

                        Layout.preferredWidth: 300
                        model: 11
                        displayText: chartName(currentIndex)
                        delegate: MenuItem {
                            width: parent.width
                            text: chartName(index)
                        }
                    }

                    Label{
                        text: "theme"
                    }
                    ComboBox{
                        id: itheme

                        Layout.preferredWidth: 300
                        model:["Light","BlueCerulean","Dark","BrownSand","BlueNcs"
                            ,"HighContrast","BlueIcy","Qt"]
                    }

                    CheckBox{
                        id: ilegendCheck
                        text: "legend"
                    }
                    Item{
                        Layout.preferredWidth: 1
                        Layout.preferredHeight: 1
                    }

                    Label{
                        text: "animation duration"
                    }
                    SpinBox{
                        id: ianimationDuration
                        from: 0
                        to: 10000
                        editable: true
                        value: 1000
                    }

                    Label{
                        text: "value from"
                    }
                    SpinBox{
                        id: ivalueForm
                        from: -100000
                        to: 100000
                        editable: true
                        value: 0
                        onValueChanged: currentChart.updateAxis()
                    }
                    Label{
                        text: "value to"
                    }
                    SpinBox{
                        id: ivalueTo
                        from: -100000
                        to: 100000
                        editable: true
                        value: 100
                        onValueChanged: currentChart.updateAxis()
                    }
                    Label{
                        text: "value tick"
                    }
                    SpinBox{
                        id: ivalueTick
                        from: -100000
                        to: 100000
                        editable: true
                        value: 5
                        onValueChanged: currentChart.updateAxis()
                    }
                    Label{
                        text: "range from"
                    }
                    SpinBox{
                        id: irangeForm
                        from: -100000
                        to: 100000
                        editable: true
                        value: 0
                        onValueChanged: currentChart.updateAxis()
                    }
                    Label{
                        text: "range to"
                    }
                    SpinBox{
                        id: irangeTo
                        from: -100000
                        to: 100000
                        editable: true
                        value: 100
                        onValueChanged: currentChart.updateAxis()
                    }
                    Label{
                        text: "range tick"
                    }
                    SpinBox{
                        id: irangeTick
                        from: -100000
                        to: 100000
                        editable: true
                        value: 5
                        onValueChanged: currentChart.updateAxis()
                    }
                }

                Column{
                    Label{
                        text: "Preview"
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

            }
            Item{
                width: 40
                height: 40
            }
            Column{
                width: parent.width
                Label{
                    text: "Chart Data"
                }
                ChartTable{
                    id: ichartTable
                }
            }
        }
    }
}
