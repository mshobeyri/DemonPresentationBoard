import QtQuick 2.12
import QtCharts 2.3

ChartBaseBar{
    id: iroot

    name: "Bar Chart"
    type: ChartView.SeriesTypeBar
    ranageAxis: iseries.axisY
    series: iseries

    BarSeries{
        id: iseries

        axisX: iroot.valueAxis
    }
}
