import QtQuick 2.12
import QtCharts 2.3

ChartBase{
    id: iroot

    function clear(){
        removeAllSeries()
    }
    function updateAxis(){}
    function updateChart(){
        ivalueAxis.max = 0
        ivalueAxis.min = 0
        irangeAxis.max = 0
        irangeAxis.min = 0

        for(var i=0;i<imodel.count;i++){
            var serie = createSeries(iroot.type,imodel.get(i).label)
            serie.axisX = irangeAxis
            serie.axisY = ivalueAxis
            for(var j=0;j<imodel.get(i).values.count;j++){
                var x = Number(iheadersModel.get(j).value)
                var y = Number(imodel.get(i).values.get(j).value)
                if(iroot.type === ChartView.SeriesTypeArea){
                    serie.upperSeries.append(x,y)
                }else{
                    serie.append(x,y)
                }

                if(x > irangeAxis.max)
                    irangeAxis.max = x
                if(x < irangeAxis.min)
                    irangeAxis.min = x
                if(y > ivalueAxis.max)
                    ivalueAxis.max= y
                if(y < ivalueAxis.min)
                    ivalueAxis.min= y
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
