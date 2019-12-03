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

    property var selectedChart
    property alias imodel: ichartComponent.dataModel
    property alias iheadersModel: ichartComponent.headersModel

    function openGallery(chart){
        open()
        selectedChart = chart
        if(selectedChart!==undefined && selectedChart!==null){
            ichartComponent.fromJson(selectedChart.toJson())
            ichartType.currentIndex = ichartComponent.chartType
            itheme.currentIndex = ichartComponent.currentTheme
            ilegendCheck.checked = ichartComponent.containLegend
            ivalueForm.value = ichartComponent.valueForm
            ivalueTo.value = ichartComponent.valueTo
            ivalueTick.value = ichartComponent.valueTick
            irangeForm.value = ichartComponent.rangeForm
            irangeTo.value = ichartComponent.rangeTo
            irangeTick.value = ichartComponent.rangeTick
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
        ichartComponent.updateChart()
        if(selectedChart!==undefined && selectedChart!==null)
            selectedChart.fromJsonChart(ichartComponent.toJson())
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
                        onCurrentIndexChanged: {
                            ichartComponent.chartType = currentIndex
                            updateChart()
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
                        onCurrentIndexChanged: {
                            ichartComponent.currentTheme = currentIndex
                            updateChart()
                        }
                    }

                    CheckBox{
                        id: ilegendCheck
                        text: "legend"
                        onToggled: {
                            ichartComponent.containLegend = checked
                            updateChart()
                        }
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
                        onValueChanged: {
                            ichartComponent.valueForm = value
                            updateChart()
                        }
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
                        onValueChanged: {
                            ichartComponent.valueTo = value
                            updateChart()
                        }
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
                        onValueChanged: {
                            ichartComponent.valueTick = value
                            updateChart()
                        }
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
                        onValueChanged: {
                            ichartComponent.rangeForm = value
                            updateChart()
                        }
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
                        onValueChanged: {
                            ichartComponent.rangeTo = value
                            updateChart()
                        }
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
                        onValueChanged: {
                            ichartComponent.rangeTick = value
                            updateChart()
                        }
                    }
                }

                Column{
                    Label{
                        text: "Preview"
                    }
                    ChartComponent{
                        id: ichartComponent
                        width: 450
                        height: 400
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
