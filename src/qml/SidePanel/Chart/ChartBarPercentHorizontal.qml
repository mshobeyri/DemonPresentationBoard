import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot
    antialiasing: true
    name: "Horizontal Percent Bar Chart"
    type: ChartView.SeriesTypeHorizontalPercentBar
    ranageAxis: iseries.axisX
    series: iseries

    HorizontalPercentBarSeries{
        id: iseries

        axisY: iroot.valueAxis
    }
}
