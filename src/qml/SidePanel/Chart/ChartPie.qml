import QtQuick 2.12
import QtCharts 2.3

ChartBase{
    id: iroot

    name: "Pie Chart"
    type: ChartView.SeriesTypePie
    property real holeSize: 0.1

    function clear(){
        //        removeAllSeries()
    }
    function updateAxis(){}

    function updateChart(){
        for(var i=0;i<imodel.count;i++){
            var serie = createSeries(iroot.type,
                                     imodel.get(i).label)
//            serie.holeSize = (i/imodel.count)

            for(var j=0;j<imodel.get(i).values.count;j++){
                var y = Number(imodel.get(i).values.get(j).value)
                serie.append(imodel.get(i).lable,y)
            }
        }
    }
}
