import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    type: ChartView.SeriesTypePercentBar
    rangeAxis: iseries.axisY
    series: iseries

    PercentBarSeries{
        id: iseries

        axisX: iroot.valueAxis
    }
}
