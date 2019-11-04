var text = "text"
var image = "image"
var media = "media"
var browser = "browser"
var rectangle = "rectangle"
var circle = "circle"
var icon = "icon"
var bracket = "bracket"
var animation = "animation"
var arrow = "arrow"
var table = "table"
var chart = "chart"

function path(element){
    switch(element){
    case text:
        return  "qrc:/src/qml/Elements/ElementText.qml"
    case image:
        return "qrc:/src/qml/Elements/ElementImage.qml"
    case media:
        return "qrc:/src/qml/Elements/ElementMedia.qml"
    case browser:
        return "qrc:/src/qml/Elements/ElementImage.qml"
    case rectangle:
        return "qrc:/src/qml/Elements/ElementRectangle.qml"
    case circle:
        return "qrc:/src/qml/Elements/ElementCircle.qml"
    case icon:
        return "qrc:/src/qml/Elements/ElementIcon.qml"
    case bracket:
        return "qrc:/src/qml/Elements/ElementBracket.qml"
    case animation:
        return "qrc:/src/qml/Elements/ElementImage.qml"
    case arrow:
        return "qrc:/src/qml/Elements/ElementArrow.qml"
    case table:
        return "qrc:/src/qml/Elements/ElementTable.qml"
    case chart:
        return "qrc:/src/qml/Elements/ElementChart.qml"
    }
}
