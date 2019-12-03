import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    type: ChartView.SeriesTypeStackedBar
    rangeAxis: iseries.axisY
    series: iseries

    StackedBarSeries{
        id: iseries

        axisX: iroot.valueAxis
    }
}
