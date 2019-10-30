import QtQuick 2.0
import QtCharts 2.3

ElementBase{
    id: icontainer
    property color color: "blue"
    property color borderColor: "white"
    property real borderWidth: 10
    component:  Component {
        Rectangle{
            ChartView {
                anchors.fill: parent
                anchors.margins: -10
                theme: ChartView.ChartThemeHighContrast
                antialiasing: true

                PieSeries {
                    id: pieSeries
                    PieSlice { label: "eaten"; value: 94.9 ;}
                    PieSlice { label: "not yet eaten"; value: 5.1 }
                }
            }
        }
    }
}
