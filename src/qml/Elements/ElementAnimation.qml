import QtQuick 2.12
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property bool evoked:false
    property bool animeEnable: false
    property string text : "Your Text Here!"
    property int textJustify: TextEdit.AlignLeft
    property string textColorHelper: "foreground"
    property string color1: "foreground"
    property string color2: "accent"
    property string textBackgroundColor: "transparent"
    property string backgroundColor1: "transparent"
    property string backgroundColor2: "transparent"
    property string evokeInId: ""
    property int evokeInIndex: -1
    property font animeTextFont
    property int x1:100
    property int x2:100
    property int y1:100
    property int y2:100
    property int w1:100
    property int w2:100
    property int h1:100
    property int h2:100
    property int fontSize: 12
    property int s1:12
    property int s2:12
    property int r1:0
    property int r2:0
    property int animationDuration: 1000
    property int easingType: Easing.Linear

    Connections{
        target: itimeline
        onTimelineFrameOrderChanged:{
            var frameIndex = itimeline.getFrameIndex(evokeInId)
            if(frameIndex!==undefined)
                evokeInIndex = frameIndex
        }
        onTimelineFrameChanged:{
            evoked = (index >= evokeInIndex)
        }
    }

    property var json: {
        "type": Element.animation,
        "common": icontainer.commonData,
        "text": icontainer.text,
        "textJustify": icontainer.textJustify,
        "color1": icontainer.color1.toString(),
        "color2": icontainer.color2.toString(),
        "backgroundColor1": icontainer.backgroundColor1.toString(),
        "backgroundColor2": icontainer.backgroundColor2.toString(),
        "animeTextFont": icontainer.animeTextFont,
        "x1": icontainer.x1,
        "x2": icontainer.x2,
        "y1": icontainer.y1,
        "y2": icontainer.y2,
        "w1": icontainer.w1,
        "w2": icontainer.w2,
        "h1": icontainer.h1,
        "h2": icontainer.h2,
        "r1": icontainer.r1,
        "r2": icontainer.r2,
        "s1": icontainer.s1,
        "s2": icontainer.s2,
        "evokeIndex": icontainer.evokeInIndex,
        "evokeId": icontainer.evokeInId,
        "animationDuration": animationDuration,
        "easingType":easingType
    }

    function fromJson(json){
        textJustify = json.textJustify
        animeTextFont.family = json.animeTextFont.family
        animeTextFont.bold = json.animeTextFont.bold
        animeTextFont.italic = json.animeTextFont.italic
        animationDuration = json.animationDuration
        easingType = json.easingType

        textColorHelper = json.color1
        color1 = json.color1
        color2 = json.color2

        textBackgroundColor = json.backgroundColor1
        backgroundColor1 = json.backgroundColor1
        backgroundColor2 = json.backgroundColor2

        x =  json.x1
        x1 = json.x1
        x2 = json.x2
        y =  json.y1
        y1 = json.y1
        y2 = json.y2
        w =  json.w1
        w1 = json.w1
        w2 = json.w2
        h =  json.h1
        h1 = json.h1
        h2 = json.h2
        r =  json.r1
        r1 = json.r1
        r2 = json.r2
        s1 = json.s1
        s2 = json.s2
        evokeInIndex= json.evokeIndex
        evokeInId= json.evokeId
        fontSize =  json.s1
        animeEnable = true
    }
    onCreated: {
        x1 = x
        x2 = x
        y1 = y
        y2 = y
        s1 =  Math.floor(h / 8)
        s2 =  Math.floor(h / 8)
        fontSize = Math.floor(h / 8)
        h = loader.item.textElement.paintedHeight
        w = loader.item.textElement.paintedWidth
        h1 = loader.item.textElement.paintedHeight
        w1 = loader.item.textElement.paintedWidth
        h2 = loader.item.textElement.paintedHeight
        w2 = loader.item.textElement.paintedWidth
        animeEnable = true
    }

    onAngleChanged: {
        if(evoked)
            r2 = r
        else
            r1 = r
    }
    onPositionChanged: {
        if(evoked){
            x2 = x
            y2 = y
        } else {
            x1 = x
            y1 = y
        }
    }
    onSizeChanged: {
        if(evoked){
            w2 = w
            h2 = h
        } else {
            w1 = w
            h1 = h
        }
    }

    onDoubleClicked:{
        icontainer.editMode = true
        currentElement = icontainer
    }
    onSelectedChanged: {
        if(!selected)
            icontainer.editMode = false
    }

    NumberAnimation on x {
        duration: animationDuration
        easing.type: easingType
        to: x2
        running:animeEnable &&  evoked
    }
    NumberAnimation on x {
        duration: animationDuration
        easing.type: easingType
        to: x1
        running: animeEnable && !evoked
    }
    NumberAnimation on y {
        duration: animationDuration
        easing.type: easingType
        to: y2
        running: animeEnable && evoked
    }
    NumberAnimation on y {
        duration: animationDuration
        easing.type: easingType
        to: y1
        running: animeEnable && !evoked
    }
    NumberAnimation on w {
        duration: animationDuration
        easing.type: easingType
        to: w2
        running: animeEnable && evoked
    }
    NumberAnimation on w {
        duration: animationDuration
        easing.type: easingType
        to: w1
        running: animeEnable && !evoked
    }
    NumberAnimation on h {
        duration: animationDuration
        easing.type: easingType
        to: h2
        running: animeEnable && evoked
    }
    NumberAnimation on h {
        duration: animationDuration
        easing.type: easingType
        to: h1
        running: animeEnable && !evoked
    }
    RotationAnimation on r {
        duration: animationDuration
        easing.type: easingType
        to: r2
        running: animeEnable && evoked
    }
    RotationAnimation on r {
        duration: animationDuration
        easing.type: easingType
        to: r1
        running: animeEnable && !evoked
    }
    ColorAnimation on textColorHelper {
        duration: animationDuration
        easing.type: easingType
        to: ithemeGallery.themeColor(icontainer.color2)
        running: animeEnable && evoked
    }
    ColorAnimation on textColorHelper {
        duration: animationDuration
        easing.type: easingType
        to: ithemeGallery.themeColor(icontainer.color1)
        running: animeEnable && !evoked
    }
    ColorAnimation on textBackgroundColor {
        duration: animationDuration
        easing.type: easingType
        to: ithemeGallery.themeColor(icontainer.backgroundColor2)
        running: animeEnable && evoked
    }
    ColorAnimation on textBackgroundColor {
        duration: animationDuration
        easing.type: easingType
        to: ithemeGallery.themeColor(icontainer.backgroundColor1)
        running: animeEnable && !evoked
    }
    NumberAnimation on fontSize {
        duration: animationDuration
        easing.type: easingType
        to: s2
        running: animeEnable && evoked
    }
    NumberAnimation on fontSize {
        duration: animationDuration
        easing.type: easingType
        to: s1
        running: animeEnable && !evoked
    }
    component:  Component {
        Rectangle{
            id: irect
            anchors.fill: parent
            border.width: 1
            border.color: selected? Qt.lighter(itxt.color): "transparent"
            antialiasing: true
            clip: true
            color: textBackgroundColor
            property alias textElement: itxt
            TextEdit {
                id: itxt
                anchors.fill: parent
                anchors.margins: 2
                color: ithemeGallery.themeColor(icontainer.textColorHelper)
                enabled: editMode
                text: icontainer.text
                font.italic: icontainer.animeTextFont.italic
                font.bold: icontainer.animeTextFont.bold
                font.family: icontainer.animeTextFont.family
                font.pixelSize: fontSize
                wrapMode: TextEdit.WordWrap
                selectByMouse: true
                selectByKeyboard: true
                antialiasing: true
                horizontalAlignment: textJustify
                onTextChanged: icontainer.text = text
                Behavior on font.pointSize {
                    NumberAnimation{
                        duration: animationDuration
                        easing.type: easingType
                    }
                }
            }
        }
    }
}
