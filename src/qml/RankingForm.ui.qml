import QtQuick 2.4

import QtQuick.Controls 2.12
import QtQuick.Controls.Imagine 2.3
import QtQuick.Controls.Material 2.0

Item {
    Imagine.path: "qrc:/themes/dark"

    width: 400
    height: 400
    Rectangle {

        id: rectangle
        width: 400
        height: 400

        ListView {
            x: 0
            y: 31
            height: 333
            boundsBehavior: Flickable.StopAtBounds
            flickDeceleration: 70
            maximumFlickVelocity: 100
            contentHeight: 424
            spacing: -4

            width: 400
            model: 120

            delegate: ItemDelegate {
                text: modelData

                width: 400
            }

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }

    Rectangle {
        id: rectangle1
        x: 0
        y: -5
        width: 400
        height: 75
        radius: 6
        gradient: Gradient {
            GradientStop {
                position: 0
                color: "#3c0b0b"
            }

            GradientStop {
                position: 1
                color: "#000000"
            }
        }
        border.width: 0

        Text {
            id: element
            x: 0
            y: 22
            color: "#e4cb68"
            text: qsTr("high scores")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 25
        }
    }
}
