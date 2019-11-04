import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer
    property color color: "#333333"
    property color borderColor: "#141452"
    property real borderWidth: 10
    property var json: {
        "type":Element.rectangle,
        "common": icontainer.commonData,
        "color": icontainer.color,
        "borderColor": icontainer.borderColor,
        "borderWidth": icontainer.borderWidth
    }
    component:  Component {
        Rectangle {
            color: icontainer.color
            border.width: icontainer.borderWidth
            border.color: icontainer.borderColor
            antialiasing: true
        }
    }
}
