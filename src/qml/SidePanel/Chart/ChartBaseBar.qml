import QtQuick 2.12
import QtCharts 2.3

ChartBase{
    property alias valueAxis: iaxis
    property var rangeAxis: undefined
    property var series

    function clear(){
        iseries.clear()
    }
    function updateAxis(){
        for(var i=0;i<iheadersModel.count;i++){
            iaxis.categories[i] = iheadersModel.get(i).value
        }
        rangeAxis.min = rangeForm
        rangeAxis.max = rangeTo
        rangeAxis.tickCount = valueTick
    }
    function updateChart(){
        for(var i=0;i<imodel.count;i++){
            var values = []
            for(var j=0;j< imodel.get(i).values.count;j++){
                var value = Number(imodel.get(i).values.get(j).value)
                values.push(value)
            }
            series.append(imodel.get(i).label,values)
        }
    }

    BarCategoryAxis {
        id: iaxis
        categories: [""]
    }
}
