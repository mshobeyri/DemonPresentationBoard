import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    name: "Stacked Bar Chart"
    type: ChartView.SeriesTypeStackedBar
    ranageAxis: iseries.axisY
    series: iseries

    StackedBarSeries{
        id: iseries

        axisX: iroot.valueAxis
    }
}
