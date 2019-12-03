import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    type: ChartView.SeriesTypeHorizontalBar
    rangeAxis: iseries.axisX
    series: iseries

    HorizontalBarSeries{
        id: iseries

        axisY: iroot.valueAxis
    }
}
