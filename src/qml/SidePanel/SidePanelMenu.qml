import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Menu {
    Menu{
        title: "File"

        MenuItem{
            text: "Open"
        }
        MenuItem{
            text: "Save"
        }
        MenuItem{
            text: "SaveAs"
        }
    }
    Menu{
        title: "Edit"

        MenuItem{
            text: "Cut"
        }
        MenuItem{
            text: "Copy"
        }
        MenuItem{
            text: "Paste"
        }
    }
    MenuSeparator{}
    MenuItem{
        text: "Remote"
    }
    MenuSeparator{}
    MenuItem{
        text: "Settings"
        onClicked: isettings.open()
    }
}
