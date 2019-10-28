import QtQuick 2.12
import QtQuick.Layouts 1.12

ColumnLayout {
    width: parent.width - 20
    anchors.horizontalCenter: parent.horizontalCenter
    RowLayout{
        spacing: 10
        SidePanelLabelTextField{
            label: "x"
        }
        SidePanelLabelTextField{
            label: "y"
        }
    }
    RowLayout{

        spacing: 10
        SidePanelLabelTextField{
            label: "w"
        }
        SidePanelLabelTextField{
            label: "h"
        }
    }
    RowLayout{
        spacing: 10
        SidePanelLabelTextField{
            label: "r"
        }
        SidePanelLabelTextField{
            label: "s"
        }
    }

}
