import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.12
import ".."

CustomDialog {
    id: iroot

    dialgTitle: "Welcome"

    contentItem: RowLayout{
        spacing: 10
        WelcomeColumns{
            Layout.maximumWidth: 250
            button.text: "New Project"
            button.iconStr: "file-plus"
            label: "Templates"
            model: ListModel{
                ListElement{
                    title: "ssss"
                    subtitle : "ajsdkjash dkja skdj akjs d"
                }

                ListElement{
                    title: "ssss"
                    subtitle : "ajsdkjash dkja skdj akjs d"
                }

                ListElement{
                    title: "ssss"
                    subtitle : "ajs akj skja sjdhkajsh kddkjash dkja skdj akjs d"
                }
            }
        }
        WelcomeColumns{
            button.text: "New Project"
            button.iconStr: "file-plus"
            label: "Templates"
            Layout.fillWidth: true
            Layout.preferredWidth: 250
            model: ListModel{
                ListElement{
                    title: "ssss"
                    subtitle : "ajsdkjash dkja skdj akjs d"
                }

                ListElement{
                    title: "ssss"
                    subtitle : "ajsdkjash dkja skdj akjs d"
                }

                ListElement{
                    title: "ssss"
                    subtitle : "ajsdkjash dkja skdj akjs d"
                }
            }
        }
    }
}
