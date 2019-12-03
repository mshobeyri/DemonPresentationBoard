import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    type: ChartView.SeriesTypeHorizontalPercentBar
    rangeAxis: iseries.axisX
    series: iseries

    HorizontalPercentBarSeries{
        id: iseries

        axisY: iroot.valueAxis
    }
}
