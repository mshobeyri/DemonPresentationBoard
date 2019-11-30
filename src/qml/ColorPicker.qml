import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Window 2.12
import QtQuick.Controls.Material 2.3

Item {
    id: iroot


    property bool alphaVisible: true

    readonly property color colorValue: hsba(ihueSlider.item.value, isbPicker.saturation,
                                             isbPicker.brightness, ialphaSlider.item.value)

    function hsba(h, s, b, a) {
        var lightness = (2 - s)*b;
        var satHSL = s*b/((lightness <= 1) ? lightness : 2 - lightness);
        lightness /= 2;
        return Qt.hsla(h, satHSL, lightness, a);
    }

    Component {
        id: ipickSliderComponent

        Item {
            id: imain

            property real value: visible?Math.max(1 - ipickerCursor.y/height, 0.0):1.0
            function setValue(val){
                ipickerCursor.y = height * (1 - val)
            }
            Item {
                id: ipickerCursor
                width: parent.width
                Rectangle {
                    y: -height*0.5
                    width: parent.width; height: imain.height * 0.03
                    border.color: "black"; border.width: 1
                    color: "transparent"
                    Rectangle {
                        anchors.fill: parent; anchors.margins: 2
                        border.color: "white"; border.width: 1
                        color: "transparent"
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                function handleMouse(mouse) {
                    if (mouse.buttons & Qt.LeftButton) {
                        ipickerCursor.y = Math.max(0, Math.min(height, mouse.y));
                    }
                }
                onPositionChanged: handleMouse(mouse)
                onPressed: handleMouse(mouse)
                preventStealing: true
            }
        }
    }

    Component {
        id: inumberBoxComponent
        RowLayout {
            property alias  caption: icaptionBox.text
            property alias  value: inputBox.text
            property alias  min: numValidator.bottom
            property alias  max: numValidator.top
            property alias  decimals: numValidator.decimals

            Label {
                id: icaptionBox
                Layout.fillHeight: true
                font.pixelSize: 11; font.bold: true
                horizontalAlignment: Text.AlignRight; verticalAlignment: Text.AlignVCenter
            }
            TextField {
                id:  inputBox

                Layout.preferredWidth: 40
                Layout.preferredHeight: parent.width * 0.2
                topInset: 0
                bottomInset: 14
                topPadding: 0
                bottomPadding: 0
                selectByMouse: true
                enabled: false
                clip: false
                validator: DoubleValidator {
                    id: numValidator
                    bottom: 0; top: 1; decimals: 2
                    notation: DoubleValidator.StandardNotation
                }
                onTextChanged: {
                    if(!focus)
                        return
                    if(parent.caption==="A"){
                        ialphaSlider.item.setValue(inputBox.text / 255)
                    }else{

                    }
                }
            }
        }
    }

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Item {
            id: ihuePicker

            Layout.preferredWidth: parent.width * 0.05
            Layout.preferredHeight: parent.width * 0.4
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 1.0;  color: "#FF0000" }
                    GradientStop { position: 0.85; color: "#FFFF00" }
                    GradientStop { position: 0.76; color: "#00FF00" }
                    GradientStop { position: 0.5;  color: "#00FFFF" }
                    GradientStop { position: 0.33; color: "#0000FF" }
                    GradientStop { position: 0.16; color: "#FF00FF" }
                    GradientStop { position: 0.0;  color: "#FF0000" }
                }
            }
            Loader {
                id: ihueSlider;

                sourceComponent: ipickSliderComponent;
                anchors.fill: parent
            }
        }

        Item {
            id: ialphaPicker

            visible: alphaVisible
            Layout.preferredWidth: parent.width * 0.05
            Layout.preferredHeight: parent.width * 0.4
            ChessBoard{
                anchors.fill: parent
                cellCount: 3
            }

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color:
                            Qt.rgba(iroot.colorValue.r,iroot.colorValue.g,iroot.colorValue.b,1)
                    }
                    GradientStop { position: 1.0; color: "transparent" }
                }
            }
            Loader {
                id: ialphaSlider;

                sourceComponent: ipickSliderComponent;
                active: true;
                anchors.fill: parent
            }
        }

        Item {
            id: isbPicker

            property real hueColor : ihueSlider.item.value
            property real saturation : ipickerCursor.x/width
            property real brightness : 1 - ipickerCursor.y/height
            Layout.preferredWidth: parent.width*0.4
            Layout.preferredHeight:  parent.width*0.4
            clip: true
            Rectangle {
                anchors.fill: parent
                rotation: -90
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "white" }
                    GradientStop { position: 1.0; color: Qt.hsla(isbPicker.hueColor,1.0,0.5,1.0) }
                }
            }
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 1.0; color: "black" }
                    GradientStop { position: 0.0; color: "transparent" }
                }
            }
            Item {
                id: ipickerCursor

                property int r : 8
                Rectangle {
                    x: -parent.r; y: -parent.r
                    width: parent.r*2; height: parent.r*2
                    radius: parent.r
                    border.color: "black"; border.width: 2
                    color: "transparent"
                    Rectangle {
                        anchors.fill: parent; anchors.margins: 2;
                        border.color: "white"; border.width: 2
                        radius: width/2
                        color: "transparent"
                    }
                }
            }
            MouseArea {
                anchors.fill: parent
                function handleMouse(mouse) {
                    if (mouse.buttons & Qt.LeftButton) {
                        ipickerCursor.x = Math.max(0, Math.min(width,  mouse.x));
                        ipickerCursor.y = Math.max(0, Math.min(height, mouse.y));
                    }
                }
                onPositionChanged: handleMouse(mouse)
                onPressed: handleMouse(mouse)
                preventStealing: true
            }
        }


        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width*0.3
            visible: false
            ColumnLayout {
                anchors.fill: parent
                anchors.margins: Screen.pixelDensity * 0.5
                anchors.topMargin: 10
                spacing: 12
                Loader {
                    id: irBox
                    sourceComponent: inumberBoxComponent;
                    Layout.fillWidth: true;
                    Layout.fillHeight: false
                    onLoaded: { item.caption = "R"; item.min = 0; item.max = 255 }
                    Binding { target: irBox.item; property: "value"; value: Math.ceil(iroot.colorValue.r* 255) }
                }
                Loader {
                    id: igBox
                    sourceComponent: inumberBoxComponent;
                    Layout.fillWidth: true;
                    Layout.fillHeight: false
                    onLoaded: { item.caption = "G"; item.min = 0; item.max = 255 }
                    Binding { target: igBox.item; property: "value"; value: Math.ceil(iroot.colorValue.g* 255) }
                }
                Loader {
                    id: ibBox
                    sourceComponent: inumberBoxComponent;
                    Layout.fillWidth: true;
                    Layout.fillHeight: false
                    onLoaded: { item.caption = "B"; item.min = 0; item.max = 255 }
                    Binding { target: ibBox.item; property: "value"; value: Math.ceil(iroot.colorValue.b* 255) }
                }

                // alpha value box
                Loader {
                    id: iaBox
                    sourceComponent: inumberBoxComponent;
                    Layout.fillWidth: true;
                    Layout.fillHeight: false
                    visible: alphaVisible
                    onLoaded: { item.caption = "A"; item.min = 0; item.max = 255 }
                    Binding { target: iaBox.item; property: "value"; value: Math.ceil(iroot.colorValue.a * 255) }
                }

                // filler rectangle
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                }
            }
        }
        Column{
            Layout.leftMargin: 10
            property int size: 15
            Button{
                width: parent.size
                height: width
                Material.background: ithemeGallery.background
                flat: true
                topInset: 0
                bottomInset: 0
                onClicked: colorOutput = "background"
            }
            Button{
                width: parent.size
                height: width
                Material.background: ithemeGallery.foregraound
                flat: true
                topInset: 0
                bottomInset: 0
                onClicked: colorOutput = "foregraound"
            }

            Button{
                width: parent.size
                height: width
                Material.background: ithemeGallery.borders
                flat: true
                topInset: 0
                bottomInset: 0
                onClicked: colorOutput = "borders"
            }

            Button{
                width: parent.size
                height: width
                Material.background: ithemeGallery.primary
                flat: true
                topInset: 0
                bottomInset: 0
                onClicked: colorOutput = "primary"
            }

            Button{
                width: parent.size
                height: width
                Material.background: ithemeGallery.accent
                flat: true
                topInset: 0
                bottomInset: 0
                onClicked: colorOutput = "accent"
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
