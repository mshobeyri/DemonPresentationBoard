import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Button {
    leftPadding: height / 3 * 2
    property alias iconStr: iicon.text
    Label{
        id: iicon
        font.family: ifontAwsome.name
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
