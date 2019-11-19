import QtQuick 2.12
import QtCharts 2.3

ChartView{
    width: 400
    height: 400
    theme: ChartView.ChartThemeHighContrast
    visible: type === ichartGallery.chartType
    antialiasing: true
    property int type
    property string name
}
