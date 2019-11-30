import QtQuick 2.0

Item {

    property color background: "black"
    property color foregraound: "white"
    property color borders: "green"
    property color primary: "yellow"
    property color accent: "blue"

    function themeColor(color){
        switch(color){
        case "background":
            return ithemeGallery.background
        case "foregraound":
            return ithemeGallery.foregraound
        case "borders":
            return ithemeGallery.background
        case "primary":
            return ithemeGallery.primary
        case "accent":
            return ithemeGallery.accent
        default:
            return color
        }
    }

}
