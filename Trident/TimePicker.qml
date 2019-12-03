import QtQuick 2.12
import QtQuick.Controls 2.5

Item{
    id: iroot

    width: irow.width
    height: irow.height
    property int values
    property color color: "white"
    signal valueChanged(int value)

    function updateValue(){
        var value = iminloader.currentIndex*60 + isecloader.currentIndex
        valueChanged(value)
    }
    Row {
        id: irow
        Tumbler{
            id: iminloader
            model: 61
            width: 40
            height: 35
            visibleItemCount: 1
            currentIndex: Math.floor(values/60)
            onMovingChanged: updateValue()
            delegate:  Label {
                text: modelData
                width: parent.width
                color: iroot.color
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
            }
            background:   Item {
                MenuSeparator {
                    topPadding: 0
                    bottomPadding: 0
                    anchors.top: parent.top
                    width: 40
                }

                MenuSeparator {
                    topPadding: 0
                    bottomPadding: 0
                    anchors.bottom: parent.bottom
                    width: 40
                }
            }
            MouseArea{
                anchors.fill: parent
            }
        }
        Label{
            text: ":"
            anchors.verticalCenter: parent.verticalCenter
        }
        Tumbler{
            id: isecloader
            model: 60
            width: 40
            height: 35
            currentIndex: values%60
            onMovingChanged: updateValue()
            visibleItemCount: 1
            delegate:  Label {
                text: modelData
                color: iroot.color
                width: parent.width
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
            }
            background:   Item {
                MenuSeparator {
                    topPadding: 0
                    bottomPadding: 0
                    anchors.top: parent.top
                    width: 40
                }
                MenuSeparator {
                    topPadding: 0
                    bottomPadding: 0
                    anchors.bottom: parent.bottom
                    width: 40
                }
            }
        }
    }
    MouseArea{
        anchors.fill: parent
    }
}
