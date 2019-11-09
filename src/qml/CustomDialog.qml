import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12


Dialog {
    id: iroot

    x: isidePanel.panelsPosition.x
    y: isidePanel.panelsPosition.y
    width: isidePanel.panelsPosition.width
    height: isidePanel.panelsPosition.height
    closePolicy: "NoAutoClose"
    property alias dialgTitle : ititle.text
    Behavior on x{
        NumberAnimation{
            duration: 200
            easing.type: Easing.InOutQuint
        }
    }

    visible: true
    clip: true
    header: RowLayout{
        Label{
            id: ititle
            font.pointSize: 14
            font.bold: true
            padding: 10
            Layout.fillWidth: true
        }
        Button{
            font.family: ifontAwsome.name
            text:"times"
            flat: true
            Layout.preferredWidth: height
            padding: 10
            rightInset: 6
            leftInset: 6
            onClicked: iroot.close()
        }
    }

    background: Rectangle{
        color: Material.background
        opacity: isettings.appInterface.menuOpacity

        Frame{
            anchors.fill: parent
        }
    }
}
