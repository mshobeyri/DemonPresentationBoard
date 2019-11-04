import QtQuick 2.0
import QtCharts 2.3
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

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
