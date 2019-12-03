import QtQuick 2.0
import QtCharts 2.3
import "ElementHelper.js" as Element
import "../SidePanel/Chart"

ElementBase{
    id: icontainer

    property string chartTypeIcon:{
        return "chart-bar"
    }
    property var json: {
        "type":Element.chart,
        "common": icontainer.commonData,
        "chartData": toJson()
    }
    function fromJsonChart(json){
        loader.item.fromJson(json)
    }
    function fromJson(json){
        fromJsonChart(json.chartData)
    }

    function toJson(){
        return loader.item.toJson()
    }

    component: Component{
        ChartComponent{}
    }
}
