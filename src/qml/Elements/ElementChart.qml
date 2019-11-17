import QtQuick 2.0
import QtCharts 2.3
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer
    property string chartTypeIcon:{
        return "chart-bar"
    }
    property int chartType: 1

    component:  Component {
        Rectangle{
            ChartView {
                anchors.fill: parent
                anchors.margins: -10
                theme: ChartView.ChartThemeHighContrast
                antialiasing: true

                ValueAxis {
                    id: valueAxis
                    min: 2000
                    max: 2011
                    tickCount: 12
                    labelFormat: "%.0f"
                }
                ValueAxis {
                    id: valueAxis1
                    min: 2000
                    max: 2011
                    tickCount: 10
                    labelFormat: "%.0f"
                }
                AreaSeries {
                    name: "Russian"
                    axisX: valueAxis
                    upperSeries: LineSeries {
                        XYPoint { x: 2000; y: 1 }
                        XYPoint { x: 2001; y: 1 }
                        XYPoint { x: 2002; y: 1 }
                        XYPoint { x: 2003; y: 1 }
                        XYPoint { x: 2004; y: 1 }
                        XYPoint { x: 2005; y: 0 }
                        XYPoint { x: 2006; y: 1 }
                        XYPoint { x: 2007; y: 1 }
                        XYPoint { x: 2008; y: 4 }
                        XYPoint { x: 2009; y: 3 }
                        XYPoint { x: 2010; y: 2 }
                        XYPoint { x: 2011; y: 1 }
                    }
                }
                LineSeries{
                }

                PieSeries {
                    PieSlice{
                        label: "salam"
                        value: 12
                    }
                    Repeater{
                        model:ListModel{
                            ListElement{
                                label:"eaten"
                                value:94.9
                            }
                            ListElement{
                                label:"not eaten"
                                value:56
                            }
                        }
                        PieSlice{
                            label: model.label
                            value: model.value
                        }
                    }
                }
            }
        }
    }
}
