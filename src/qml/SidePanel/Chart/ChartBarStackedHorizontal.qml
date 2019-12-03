import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    antialiasing: true
    type: ChartView.SeriesTypeHorizontalStackedBar
    rangeAxis: iseries.axisX
    series: iseries

    HorizontalStackedBarSeries{
        id: iseries

        axisY: iroot.valueAxis
    }
}
