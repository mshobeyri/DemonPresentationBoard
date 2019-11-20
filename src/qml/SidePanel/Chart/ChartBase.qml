import QtQuick 2.12
import QtCharts 2.3

ChartView{
    width: 450
    height: 400
    theme: itheme.currentIndex
    visible: type === ichartGallery.chartType
    antialiasing: true
    legend.visible: ilegendCheck.checked
    property int type
}
