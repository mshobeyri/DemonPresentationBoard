import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

RowLayout {
    spacing: 10
    property alias label: ilable.text
    property alias value: ispinbox.value
    property int labelSize: ilable.paintedWidth
    Label{
        id: ilable
        Layout.preferredWidth: labelSize
    }
    SpinBox{
        id: ispinbox

        Layout.fillWidth: true
        editable: true
        onValueModified: if(!upDownPressed)
                             ifileManager.fileChanged()
        property var upDownPressed : up.pressed || down.pressed
        onUpDownPressedChanged: {
            if(!upDownPressed)
                ifileManager.fileChanged()
        }
    }
}
