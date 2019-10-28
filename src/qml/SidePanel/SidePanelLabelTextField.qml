import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12

RowLayout {
    spacing: 10
    property alias label: ilable.text
    property alias text: itext.text
    Label{
        id: ilable
    }
    TextField{
        id: itext
        Layout.fillWidth: true
    }
}
