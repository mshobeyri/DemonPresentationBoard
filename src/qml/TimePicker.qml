import QtQuick 2.12
import QtQuick.Controls 2.5

Row {
    id: iroot
    property int values
    signal valueChanged(int value)

    function updateValue(){
        var value = iminloader.currentIndex*60 + isecloader.currentIndex
        valueChanged(value)
    }

    Tumbler{
        id: iminloader
        model: 61
        width: 40
        height: 35
        wheelEnabled: true
        visibleItemCount: 1
        currentIndex: Math.floor(values/60)
        onMovingChanged: if(!moving)updateValue()
        delegate:  Label {
            text: modelData
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
        contentItem: ListView {
            model: iminloader.model
            delegate: iminloader.delegate

            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: height / 2 - (height / iminloader.visibleItemCount / 2)
            preferredHighlightEnd: height / 2 + (height / iminloader.visibleItemCount / 2)
            clip: true
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
        wheelEnabled: true
        currentIndex: values%60
        onMovingChanged: if(!moving)updateValue()
        visibleItemCount: 1
        delegate:  Label {
            text: modelData
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
        contentItem: ListView {
            model: isecloader.model
            delegate: isecloader.delegate

            snapMode: ListView.SnapToItem
            highlightRangeMode: ListView.StrictlyEnforceRange
            preferredHighlightBegin: height / 2 - (height / isecloader.visibleItemCount / 2)
            preferredHighlightEnd: height / 2 + (height / isecloader.visibleItemCount / 2)
            clip: true

        }
    }
}
