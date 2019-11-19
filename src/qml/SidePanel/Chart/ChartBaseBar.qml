import QtQuick 2.12
import QtCharts 2.3

ChartBase{
    property alias valueAxis: iaxis
    property var ranageAxis: undefined
    property var series

    function clear(){
        iseries.clear()
    }
    function updateAxis(){
        for(var i=0;i<iheadersModel.count;i++){
            iaxis.categories[i] = iheadersModel.get(i).value
        }
    }
    function updateChart(){
        for(var i=0;i<imodel.count;i++){
            var values = []
            for(var j=0;j< imodel.get(i).values.count;j++){
                var value = Number(imodel.get(i).values.get(j).value)
                values.push(value)
                if(ranageAxis!==undefined){
                    if(i===0 || value < ranageAxis.min)
                        ranageAxis.min = value
                    if(i===0 || value > ranageAxis.max)
                        ranageAxis.max = value
                }
            }
            series.append(imodel.get(i).label,values)
        }
        if(ranageAxis!==undefined){
            ranageAxis.max += ranageAxis.max/10
        }
    }

    BarCategoryAxis {
        id: iaxis
        categories: [""]
    }
}
