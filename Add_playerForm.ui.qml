import QtQuick 2.4
import QtQuick.Controls 2.15

Item {
    width: 379
    height: 350
    property alias rectangle1: rectangle1

    Rectangle {
        id: rectangle
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#0072b3"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        anchors.fill: parent

        Column {
            id: column
            width: 392
            anchors.fill: parent


            Rectangle {
                id: rectangle1
                width: 227
                height: 52
                color: "#ffffff"
                radius: 6
                anchors.top: parent.top
                anchors.topMargin: 65
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                border.color: "#00000000"

                TextInput {
                    id: textInput
                    x: 19
                    y: (parent.height - this.height) / 2
                    width: 80
                    height: 20
                    text: qsTr("enter name")
                    font.bold: true
                    cursorVisible: true
                    selectByMouse: true
                    persistentSelection: false
                    overwriteMode: false
                    font.pixelSize: 16
                }
            }
            Button {
                id: button
                width: 164
                height: 53
                text: qsTr("create")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                highlighted: true
                flat: false
                display: AbstractButton.TextOnly
                background: Rectangle {
                    color: "#2aa170"
                    radius: 12
                    anchors.fill: parent
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:1;anchors_height:200;anchors_width:200;anchors_x:82;anchors_y:83}
}
##^##*/

