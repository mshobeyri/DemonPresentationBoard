import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

Column{
    id: iroot

    width: parent.width
    property int labelSize: ipointSize.labelSize
    property int textJustify
    property font textFont
    property int textJustifyOutput
    property font textFontOutput
    onTextFontChanged: textFontOutput = textFont
    onTextJustifyChanged: textJustifyOutput = textJustifyOutput
    onTextJustifyOutputChanged: {
        if(visible)
            iworld.currentElement.textJustify = textJustifyOutput
    }

    onTextFontOutputChanged: {
        if(visible)
            iworld.currentElement.textFont = textFontOutput
    }

    function updateCurrentElement(){
        textFontOutput.italic = !textFontOutput.italic
        textFontOutput.italic = !textFontOutput.italic
    }

    SidePanelValueBox{
        id: ipointSize

        label: "point size"
        value: textFont.pointSize
        width: parent.width
        onValueChanged: textFontOutput.pointSize = value
    }
    SidePanelTextFormatOptions{

    }
}
