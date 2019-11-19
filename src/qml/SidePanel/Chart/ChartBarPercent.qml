import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    name: "Percent Bar Chart"
    type: ChartView.SeriesTypePercentBar
    ranageAxis: iseries.axisY
    series: iseries

    PercentBarSeries{
        id: iseries

        axisX: iroot.valueAxis
    }
}
