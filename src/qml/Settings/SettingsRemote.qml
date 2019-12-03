import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3

Item {
    clip: true
    Flickable{
        anchors.fill: parent
        contentHeight: icolumn.height
        clip: true
        interactive: contentHeight>height
        Column{
            id: icolumn
            width: parent.width
            Label{
                width: parent.width
                wrapMode: "WordWrap"
                text: "Trident is a crossplatform application to take presentation process in your hands. support for android, ios and blackberry.\n"+
                      "using trident you can:\n"+
                      "     - switch between frames\n"+
                      "     - read the notes that you have wroted in demon-pb for the frame you are in\n"+
                      "     - a fake laser pointer to point board just by touching mobile screen\n"+
                      "     - see remained time for frame\n"+
                      "     - customize your laser size and color\n\n\n"+
                      "How to use:\n\n"+
                      "     1. Download Trident application using Following link\n"
            }
            Label{
                text: "             https://github.com/mshobeyri/DemonPresentationBoard/releases"
                Material.foreground: Material.Blue
            }
            Label{
                width: parent.width
                wrapMode: "WordWrap"
                text: "\n     2. Connect your pc and mobile to same network(mobile hotspot is recomended)\n"+
                      "     3. From trident click on wifi logo and press magic icon(it's upnp, don't take it that much serious)\n"+
                      "     4. If it does not work, use your fingers and add following address/addresses should work\n"
            }
            Repeater{
                model: JSON.parse(upnp.urls())
                delegate: Label{
                    text: "             "+modelData
                    Material.foreground: Material.Blue
                }
            }
            Label{
                text:"\n     5. Enjoy!"
            }
        }
    }
}
