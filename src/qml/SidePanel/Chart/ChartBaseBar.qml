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
        for(var i=0;i<headersModel.count;i++){
            iaxis.categories[i] = headersModel.get(i).value
        }
        rangeAxis.min = rangeForm
        rangeAxis.max = rangeTo
        rangeAxis.tickCount = rangeTick
    }
    function updateChart(){
        for(var i=0;i<dataModel.count;i++){
            var values = []
            for(var j=0;j< dataModel.get(i).values.count;j++){
                var value = Number(dataModel.get(i).values.get(j).value)
                values.push(value)
            }
            series.append(dataModel.get(i).label,values)
        }
    }

    BarCategoryAxis {
        id: iaxis
        categories: [""]
    }
}
