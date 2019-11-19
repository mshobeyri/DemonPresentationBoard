import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import QtCharts 2.3
import "../.."

CustomDialog {
    id: ichartGallery

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
        default: return ipieChart
        }
    }

    function toJsValues(valuesModel){
        return values
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
    Flickable{
        contentHeight: icolumn.height
        interactive: height < contentHeight || width < contentWidth
        anchors.fill: parent
        Column{
            id: icolumn
            width: parent.width
            GridLayout{
                columns: 2
                Label{
                    text: "type"
                }
                ComboBox{
                    id: ichartType

                    Layout.preferredWidth: 300
                    model: 13
                    displayText: getChart(currentIndex).name
                    delegate: MenuItem {
                        width: parent.width
                        text: getChart(index).name
                    }
                }
                Label{
                    text: "value from"
                }
                SpinBox{

                }
                Label{
                    text: "value to"
                }
                SpinBox{

                }
                Label{
                    text: "range from"
                }
                SpinBox{

                }
                Label{
                    text: "range to"
                }
                SpinBox{

                }
            }
            Item{
                width: 40
                height: 40
            }

            Label{
                text: "Chart Data"
            }
            ChartTable{
                id: ichartTable
            }
            Item{
                width: 40
                height: 40
            }

            Label{
                text: "Preview"
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
                    function updateAxis(){}
                    function updateChart(){
                        for(var i=0;i<imodel.count;i++){
                            ipieChart.append(imodel.get(i).label,Number(imodel.get(i).values.get(0).value))
                        }
                    }
                }
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
                name: "Line Chart"
            }
            ChartBaseXY{
                id: isplineChart
                type: ChartView.SeriesTypeSpline
                name: "Spline Chart"
            }
            ChartBaseXY{
                id: iareaChart
                type: ChartView.SeriesTypeArea
                name: "Area Chart"
            }
            ChartBaseXY{
                id: iscatterChart
                type: ChartView.SeriesTypeScatter
                name: "Scatter Chart"
            }
        }
    }
}
