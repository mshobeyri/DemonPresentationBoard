import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

RowLayout {
    spacing: 10


    visible: optionVisible('leftMarker')
    leftMarker: visible? iworld.currentElement.leftMarker:""
    rightMarker: visible? iworld.currentElement.rightMarker:""

    property int labelSize: ilable.paintedWidth

    property alias leftMarkerIndex: ileftMarkerCombo.currentIndex
    property alias rightMarkerIndex: irightMarkerCombo.currentIndex

    property string leftMarker
    property string rightMarker

    property string leftMarkerOutput: ileftMarkerCombo.currentText
    property string rightMarkerOutput: irightMarkerCombo.currentText

    onLeftMarkerOutputChanged: if(visible)iworld.currentElement.leftMarker = leftMarkerOutput
    onRightMarkerOutputChanged:  if(visible)iworld.currentElement.rightMarker = rightMarkerOutput

    onLeftMarkerChanged: ileftMarkerCombo.currentIndex
                         = ileftMarkerCombo.find(leftMarker)
    onRightMarkerChanged: irightMarkerCombo.currentIndex
                         = irightMarkerCombo.find(rightMarker)

    Label{
        id: ilable
        text: "markers"
        Layout.preferredWidth: labelSize
    }
    ComboBox{
        id: ileftMarkerCombo

        model: ["","triangle","circle","stop"]
        font.bold: true
        Layout.preferredWidth: height
        font.family: ifontAwsome.name
        indicator: Item{}
        topInset: 0
        bottomInset: 0
        rightInset: 0
        leftInset: 0
        contentItem: Label {
            text: parent.displayText
            font: ifontAwsome.name
            padding: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            rotation: -90
        }
        delegate: ItemDelegate{
            text: modelData
            font.family: ifontAwsome.name
            font.bold: true
            width: parent.width
            height: parent.width
            highlighted: ileftMarkerCombo.highlightedIndex === index
            contentItem: Label {
                text: modelData
                font: ifontAwsome.name
                padding: 0
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                rotation: -90
            }
        }
    }
    ComboBox{
        id: irightMarkerCombo

        model: ["","triangle","circle","stop"]]
        font.bold: true
        Layout.preferredWidth: height
        font.family: ifontAwsome.name
        indicator: Item{}
        topInset: 0
        bottomInset: 0
        rightInset: 0
        leftInset: 0
        contentItem: Label {
            text: parent.displayText
            font: ifontAwsome.name
            padding: 0
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            rotation: 90
        }
        delegate: ItemDelegate{
            text: modelData
            font.family: ifontAwsome.name
            font.bold: true
            width: parent.width
            height: parent.width
            highlighted: irightMarkerCombo.highlightedIndex === index
            contentItem: Label {
                text: modelData
                font: ifontAwsome.name
                padding: 0
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                rotation: 90
            }
        }
    }
}
