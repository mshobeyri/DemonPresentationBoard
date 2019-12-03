import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import Qt.labs.settings 1.1

import ".."
import "../SidePanel"


CustomDialog {
    id: iroot

    dialgTitle: "Theme gallery"

    property bool isEditable: false
    property string name: ""
    property color backgroundColor: "#2e1012"
    property color foregroundColor:  "#a28b8a"
    property color borderColor: "#825b35"
    property color primaryColor: "#5b3131"
    property color accentColor: "#bf5f5f"

    function themeColor(color){
        switch(color){
        case "background":
            return backgroundColor
        case "foreground":
            return foregroundColor
        case "border":
            return borderColor
        case "primary":
            return primaryColor
        case "accent":
            return accentColor
        default:
            return color
        }
    }
    function toJson(){
        return {
            "background":backgroundColor.toString(),
            "foreground" :foregroundColor.toString(),
            "border":borderColor.toString(),
            "primary":primaryColor.toString(),
            "accent":accentColor.toString()
        }
    }
    function fromJson(json){
        backgroundColor = json.background
        foregroundColor = json.foreground
        borderColor = json.border
        primaryColor = json.primary
        accentColor = json.accent

        for(var i=0;i<ilistModel.count;i++){
            var element = ilistModel.get(i)
            if(element.background.toUpperCase() === backgroundColor.toString().toUpperCase() &&
                    element.foreground.toUpperCase() === foregroundColor.toString().toUpperCase() &&
                    element.border.toUpperCase() === borderColor.toString().toUpperCase() &&
                    element.primary.toUpperCase() === primaryColor.toString().toUpperCase() &&
                    element.accent.toUpperCase() === accentColor.toString().toUpperCase()){
                ilistview.currentIndex = i
                iroot.name = ilistModel.get(i).name
                break
            }
        }
    }

    function userThemesToJson(){
        var json = []
        for(var i=0;i< ilistModel.count;i++){
            var element = ilistModel.get(i)
            if(!element.editable)
                continue
            json.push({
                          "name": element.name ,
                          "background":element.background ,
                          "foreground" :element.foreground ,
                          "border":element.border ,
                          "primary":element.primary ,
                          "accent":element.accent
                      })


        }
        return json
    }
    function userThemesFromJson(json){
        for(var i=0;i<json.length;i++){
            var element = json[i]
            ilistModel.append({
                                  "name": element.name ,
                                  "background":element.background ,
                                  "foreground" :element.foreground ,
                                  "border":element.border ,
                                  "primary":element.primary ,
                                  "accent":element.accent,
                                  "editable": true
                              })
        }
    }

    function save(){
        var json = userThemesToJson()
        ithemeSettings.themeString = JSON.stringify(json)
    }

    function load(jsonStr){
        if(jsonStr==="")
            return
        for(var i=0;i<ilistModel.count;i++){
            if(ilistModel.get(i).editable)
                ilistModel.remove(i)
        }

        userThemesFromJson(JSON.parse(jsonStr))
    }

    Settings{
        id: ithemeSettings

        property string themeString: ""
    }

    Component.onCompleted: {
        load(ithemeSettings.themeString)
    }

    Row{
        height: parent.height
        ListView{
            id: ilistview

            width: 300
            height: parent.height
            currentIndex: -1
            clip: true
            model: ListModel{
                id: ilistModel
                ListElement{
                    name: "Hell"
                    background: "#2e1012"
                    foreground : "#a28b8a"
                    border: "#825b35"
                    primary: "#5b3131"
                    accent: "#bf5f5f"
                    editable: false
                }
                ListElement{
                    name: "Liver"
                    background: "#2e1012"
                    foreground : "#f67280"
                    border: "#2d132c"
                    primary: "#FF6334"
                    accent: "#BE1F1D"
                    editable: false
                }
                ListElement{
                    name: "Mold"
                    background: "#626500"
                    foreground : "#B29C27"
                    border: "#FFB400"
                    primary: "#FF6334"
                    accent: "#ee4540"
                    editable: false
                }
                ListElement{
                    name: "Happy"
                    background: "#F5B700"
                    foreground : "#33CC33"
                    border: "#00A1E4"
                    primary: "#DC0073"
                    accent: "#89FC00"
                    editable: false
                }
                ListElement{
                    name: "Pole"
                    background: "#CCDAE0"
                    foreground : "#87ABBA"
                    border: "#EAA70B"
                    primary: "#FFFFFF"
                    accent: "#262626"
                    editable: false
                }
                ListElement{
                    name: "Grave"
                    background: "#432E36"
                    foreground : "#080708"
                    border: "#0D0C1D"
                    primary: "#BA2C73"
                    accent: "#191D32"
                    editable: false
                }
                ListElement{
                    name: "Paris"
                    background: "#182047"
                    foreground : "#EF0E11"
                    border: "#282828"
                    primary: "#FFFFFF"
                    accent: "#CBB26A"
                    editable: false
                }
                ListElement{
                    name: "Foggy Forest"
                    background: "#C4BBAF"
                    foreground : "#A5978B"
                    border: "#5C4742"
                    primary: "#212922"
                    accent: "#3C5948"
                    editable: false
                }
                ListElement{
                    name: "Soft"
                    background: "#247BA0"
                    foreground : "#70C1B3"
                    border: "#B2DBBF"
                    primary: "#F3FFBD"
                    accent: "#FF1654"
                    editable: false
                }
                ListElement{
                    name: "Pink"
                    background: "#F2D7EE"
                    foreground : "#D3BCC0"
                    border: "#A5668B"
                    primary: "#69306D"
                    accent: "#0E103D"
                    editable: false
                }
                ListElement{
                    name: "Blue"
                    background: "#007EA7"
                    foreground : "#FFFFFF"
                    border: "#00171F"
                    primary: "#003459"
                    accent: "#00A8E8"
                    editable: false
                }
                ListElement{
                    name: "Jean"
                    background: "#003049"
                    foreground : "#D62828"
                    border: "#F77F00"
                    primary: "#FCBF49"
                    accent: "#EAE2B7"
                    editable: false
                }
            }

            section.delegate: Label{
                topPadding: 20
                text: section==="true"?"user themes":"demon themes"
                Material.foreground: Material.accent
            }
            section.property: "editable"

            delegate: MenuItem{
                width: 300
                text: model.name
                highlighted: model.index === ilistview.currentIndex
                onHighlightedChanged: {
                    if(highlighted){
                        iroot.isEditable = model.editable
                        iroot.name = model.name
                        backgroundColor = model.background
                        foregroundColor = model.foreground
                        borderColor = model.border
                        primaryColor = model.primary
                        accentColor = model.accent
                        ifileManager.fileChanged()
                    }
                }

                onClicked: {
                    ilistview.currentIndex = model.index
                }

                Row{
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 1
                    height: parent.height / 5
                    Rectangle{
                        color: model.background
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.foreground
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.border
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.primary
                        width: parent.height
                        height: width
                    }
                    Rectangle{
                        color: model.accent
                        width: parent.height
                        height: width
                    }
                }
            }
        }
        ToolSeparator{
            height: parent.height
        }

        ColumnLayout{
            width: 300
            RowLayout{
                Item{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }

                ToolButton{
                    text: "trash-alt"
                    font.family: ifontAwsome.name
                    enabled: iroot.isEditable
                    Material.foreground: "red"
                    ToolTip.text: "Remove theme"
                    ToolTip.delay: 0
                    ToolTip.visible: hovered
                    onClicked: {
                        ilistModel.remove(ilistview.currentIndex)
                        ilistview.currentIndex = -1
                        save()
                    }
                }

                ToolButton{
                    text: "Save"
                    font.family: ifontAwsome.name
                    enabled: iroot.isEditable
                    ToolTip.text: "Save theme"
                    ToolTip.delay: 0
                    ToolTip.visible: hovered
                    onClicked: {
                        var element = ilistModel.get(ilistview.currentIndex)
                        element.name = inameTextField.text
                        element.background = backgroundColor.toString()
                        element.foreground = foregroundColor.toString()
                        element.border = borderColor.toString()
                        element.primary = primaryColor.toString()
                        element.accent = accentColor.toString()
                        save()
                    }
                }
                ToolButton{
                    text: "plus"
                    font.family: ifontAwsome.name
                    ToolTip.text: "Add theme"
                    ToolTip.delay: 0
                    ToolTip.visible: hovered

                    onClicked: {
                        ilistModel.append(
                                    {
                                        "name":inameTextField.text,
                                        "background": backgroundColor.toString(),
                                        "foreground" : foregroundColor.toString(),
                                        "border": borderColor.toString(),
                                        "primary": primaryColor.toString(),
                                        "accent": accentColor.toString(),
                                        "editable": true
                                    });
                        save()
                    }
                }

            }

            SidePanelLabelTextField{
                id: inameTextField
                labelSize: ibackgrondColorSelector.labelSize
                label: "Name"
                text: iroot.name
                Layout.rightMargin: 50
            }

            SidePanelColorSelector{
                id: ibackgrondColorSelector
                color: backgroundColor
                label: "Background"
                onColorOutputChanged: backgroundColor = colorOutput
                visibleThemeColors: false
            }
            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: foregroundColor
                label: "Foreground"
                onColorOutputChanged: foregroundColor = colorOutput
                visibleThemeColors: false
            }
            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: borderColor
                label: "Border"
                onColorOutputChanged: borderColor = colorOutput
                visibleThemeColors: false
            }

            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: primaryColor
                label: "Primary"
                onColorOutputChanged: primaryColor = colorOutput
                visibleThemeColors: false
            }

            SidePanelColorSelector{
                labelSize: ibackgrondColorSelector.labelSize
                color: accentColor
                label: "Accent"
                onColorOutputChanged: accentColor = colorOutput
                visibleThemeColors: false
            }
        }
    }
}
