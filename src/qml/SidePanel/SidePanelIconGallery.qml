import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."
import "SidePanelIconsJs.js" as JsModel

CustomDialog {
    id: iroot

    dialgTitle: "Icon Gallery"
    visible: false

    property var selectedIcon

    Component.onCompleted: {
        for(var i= 0;i<JsModel.icons.length;i++){
            imodel.append({ "category":JsModel.icons[i].label,
                              "icons": JSON.stringify(JsModel.icons[i].icons),
                              "bold":true
                          })
        }
        for(i= 0;i<JsModel.icons.length;i++){
            imodel.append({ "category":JsModel.icons[i].label,
                              "icons": JSON.stringify(JsModel.icons[i].icons),
                              "bold":false
                          })
        }
    }
    function openGallery(icon){
        open()
        selectedIcon = icon
    }
    ListModel{
        id: imodel
    }
    ColumnLayout{
        anchors.fill: parent
        RowLayout{
            Label{
                text: "Search"
            }
            TextField{
                id: isearchFields

                Layout.fillWidth: true
                selectByMouse: true
            }
        }

        ListView{
            id: ilist

            Layout.fillWidth: true
            Layout.fillHeight: true
            model: imodel
            clip: true
            section.property: "bold"

            section.delegate :  Label {
                text: section=="true"?"SOLID":"REGULAR"
                font.bold: true
                font.pointSize: 14
                topPadding: 20
                bottomPadding: 20
                leftPadding: 20
                Material.foreground: Material.Grey
            }
            delegate: Column{
                id: idelegate

                leftPadding: 40
                function modelObj(){
                    return model
                }
                Label{
                    id: icategory

                    text: model.category
                    topPadding: 10
                    font.pointSize: 12
                    Material.foreground: Material.accent
                    visible: isearchFields.text==="" ||
                             model.icons.indexOf(isearchFields.text)!==-1
                }
                MenuSeparator{
                    visible: icategory.visible
                    width: iwin.width
                }

                Grid{
                    columns: iroot.width / 40
                    Repeater{
                        model: JSON.parse(idelegate.modelObj().icons)
                        ToolButton{
                            visible: isearchFields.text === "" ||
                                     modelData.indexOf(isearchFields.text)!==-1
                            text: modelData
                            flat: true
                            font.bold: idelegate.modelObj().bold
                            font.family: idelegate.modelObj().bold?
                                             ifontAwsome.name:ifontAwsomereg.name
                            onClicked: {
                                if(selectedIcon === null)
                                    return
                                selectedIcon.icon = modelData
                                selectedIcon.fontFamilyName = font.family
                                selectedIcon.bold = font.bold
                                ifileManager.fileChanged()
                            }
                        }
                    }
                }
            }
        }
    }
}
