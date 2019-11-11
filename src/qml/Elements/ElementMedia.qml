import QtQuick 2.12
import QtAV 1.6
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Qt.labs.platform 1.1
import "ElementHelper.js" as Element

ElementBase{
    id: icontainer

    property string tempName: ""
    property string source: ""
    property color color: "#000000"
    property var json: {
        "type":Element.media,
        "common": icontainer.commonData,
        "tempName": icontainer.tempName,
        "color": icontainer.color.toString(),
    }
    function fromJson(json){
        source = fileio.tempFolderFileUrl(json.tempName)
        color = json.color
    }

    onCreated: {
        if(icontainer.source == "")
            isourceSelector.open()
    }

    FileDialog{
        id: isourceSelector
        nameFilters: ["Video files (*.mp4 *.avi *.mov *.mkv *.wmv)", "All files (*.*)"]
        onAccepted: {
            icontainer.tempName = fileio.copyToTempFolder(currentFile)
            icontainer.source = fileio.tempFolderFileUrl(tempName)
        }
        onRejected: icontainer.deleteIt()
    }

    component:  Component {
        Video {
            id: imediaplayer

            source: icontainer.source
            antialiasing: true
            backgroundColor: icontainer.color
            Item{
                width: parent.width
                height: irowLayout.height
                anchors.bottom: parent.bottom
                opacity: imousarea.containsMouse || ibutton.hovered || islider.hovered?1 : 0
                parent: icontainer.selectDragMouseArea
                Behavior on opacity{
                    NumberAnimation{duration: 200}
                }

                Rectangle{
                    anchors.fill: parent
                    opacity: 0.7
                    antialiasing: true
                    gradient: Gradient {
                        GradientStop {
                            position: 0
                            color: "transparent"
                        }

                        GradientStop {
                            position: 0.29
                            color: "#000000"
                        }
                    }
                }
                MouseArea{
                    id: imousarea

                    anchors.fill: parent
                    hoverEnabled: true
                }

                RowLayout{
                    id: irowLayout
                    width: parent.width
                    height: ibutton.height + 10
                    Button{
                        id: ibutton
                        leftInset: 0
                        rightInset: 0
                        topInset: 0
                        bottomInset: 0
                        flat: true
                        Layout.preferredWidth: 30
                        Layout.preferredHeight: 30
                        font.family: ifontAwsome.name
                        antialiasing: true

                        text: {
                            if (imediaplayer.playbackState === MediaPlayer.PlayingState) {
                                "pause"
                            } else {
                                "play"
                            }
                        }
                        onClicked: {
                            if (imediaplayer.playbackState === MediaPlayer.PlayingState) {
                                imediaplayer.pause()
                            } else {
                                imediaplayer.play()
                            }
                        }
                    }

                    Slider{
                        id: islider
                        Layout.fillWidth: true
                        leftPadding: -5
                        topPadding: 0
                        bottomPadding: 0
                        antialiasing: true
                        value: imediaplayer.position/imediaplayer.duration
                        Material.accent: Material.Grey
                        onMoved: {
                            imediaplayer.seek(value * imediaplayer.duration)
                        }
                        background{
                            antialiasing: true
                        }
                    }
                }
            }
        }
    }
}
