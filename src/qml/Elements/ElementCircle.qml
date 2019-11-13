import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    fixAspectRatio: true
    property color color: "blue"
    property color borderColor: "white"
    property real borderWidth: 10
    property var json: {
        "type":Element.circle,
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
            color: icontainer.color
            width: height
            border.width: icontainer.borderWidth
            border.color: icontainer.borderColor
            antialiasing: true
            smooth: true
            radius: width
        }
    }
}
