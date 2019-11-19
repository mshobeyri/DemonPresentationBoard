import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot
    antialiasing: true
    name: "Stacked Horizontal Bar Chart"
    type: ChartView.SeriesTypeHorizontalStackedBar
    ranageAxis: iseries.axisX
    series: iseries

    HorizontalStackedBarSeries{
        id: iseries

        axisY: iroot.valueAxis
    }
}
