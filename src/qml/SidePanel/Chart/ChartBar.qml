import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    type: ChartView.SeriesTypeBar
    rangeAxis: iseries.axisY
    series: iseries

    BarSeries{
        id: iseries

        axisX: iroot.valueAxis
    }
}
