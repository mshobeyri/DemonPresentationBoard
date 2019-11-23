import QtQuick 2.12
import QtCharts 2.3

ChartBase{
    id: iroot

    type: ChartView.SeriesTypeScatter

    function clear(){
        removeAllSeries()
    }
    function updateAxis(){
        irangeAxis.min = rangeForm
        irangeAxis.max = rangeTo
        irangeAxis.tickCount = rangeTick
        ivalueAxis.min = valueForm
        ivalueAxis.max = valueTo
        ivalueAxis.tickCount = valueTick
    }

    function updateChart(){
        for(var i=0;i<dataModel.count;i++){
            var serie = createSeries(iroot.type,dataModel.get(i).label)
            serie.axisX = irangeAxis
            serie.axisY = ivalueAxis

            for(var j=0;j<dataModel.get(i).values.count;j++){
                var x = Number(headersModel.get(j).value)
                var y = Number(dataModel.get(i).values.get(j).value)
                if(iroot.type === ChartView.SeriesTypeArea){
                    serie.upperSeries.append(x,y)
                }else{
                    serie.append(x,y)
                }
            }
        }
    }
    ValueAxis{
        id: irangeAxis
    }

    ValueAxis{
        id: ivalueAxis
    }
}
