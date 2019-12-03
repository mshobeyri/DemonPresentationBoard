import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    baseWidth: 100
    baseHeight: 100
    property string color: "primary"
    property string borderColor: "border"
    property real borderWidth: 10
    property var json: {
        "type":Element.rectangle,
        "common": icontainer.commonData,
        "color": icontainer.color.toString(),
        "borderColor": icontainer.borderColor.toString(),
        "borderWidth": icontainer.borderWidth
    }
    function fromJson(json){
        color = json.color
        borderColor = json.borderColor
        borderWidth = json.borderWidth
    }
    component:  Component {
        Rectangle {
            color: ithemeGallery.themeColor(icontainer.color)
            border.width: icontainer.borderWidth
            border.color: ithemeGallery.themeColor(icontainer.borderColor)
            antialiasing: true
        }
    }
}
