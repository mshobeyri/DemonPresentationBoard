import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

RowLayout {
    id: iroot

    spacing: 10
    property alias label: ilable.text
    property alias text: itext.text
    property alias textFocus: itext.focus
    property int labelSize: ilable.paintedWidth
    property alias validationRegex: iregex.regExp
    property alias isValid: itext.acceptableInput
    Label{
        id: ilable
        Layout.preferredWidth: labelSize
    }
    TextField{
        id: itext

        Layout.fillWidth: true
        selectByMouse: true
        onAccepted: {
            focus = false
        }
        validator: RegExpValidator{
            id: iregex
        }
        onEditingFinished: {
            ifileManager.fileChanged()
        }
    }
}
