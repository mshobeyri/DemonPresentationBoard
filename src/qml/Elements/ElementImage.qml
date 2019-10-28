import QtQuick 2.12

ElementBase{
    id: icontainer
    property string source: "qrc:/res/res/image.svg"
    component:  Component {
        Image {
            source: icontainer.source
            sourceSize: Qt.size(width,height)
            antialiasing: true
        }
    }
}
