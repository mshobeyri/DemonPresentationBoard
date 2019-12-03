import QtQuick 2.12
import QtCharts 2.3

ChartBase{
    id: iroot

    type: ChartView.SeriesTypePie
    property real holeSize: 0.1

    function clear(){
        removeAllSeries()
    }
    function updateAxis(){}

    function updateChart(){
        if(imodel.get(0)===undefined)
            return
        for(var j=0;j<imodel.get(0).values.count;j++){
            for(var i=0;i<imodel.count;i++){
                var serie = createSeries(iroot.type,
                                         imodel.get(i).label)
                serie.holeSize = (i/imodel.count)
                serie.z = i
                var header = iheadersModel.get(j)
                if(header === undefined) return
                var y = Number(imodel.get(i).values.get(j).value)
                var l = imodel.get(0).values.count===1 ||
                        header.value===""?
                            imodel.get(i).label:
                            header.value+"-"
                            +imodel.get(i).label


                series(j).append(l, y)
            }
        }
    }
}
