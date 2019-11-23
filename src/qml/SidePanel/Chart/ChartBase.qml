import QtQuick 2.12
import QtCharts 2.3

ChartView{
    width: parent.width
    height: parent.height
    theme: currentTheme
    visible: type === chartType
    antialiasing: true
    legend.visible: containLegend
    property int type
}

