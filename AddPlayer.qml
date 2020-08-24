import QtQuick 2.9
import QtQuick.Controls 2.5

Item{

    id: add_player

    width: 500
    height: 500
    visible: true
    Rectangle {
        id: rectangle
        color: "#131f27"
        anchors.fill: parent

        Button {
            width:100
            id: button
            y: 180
            text: qsTr("Add Player")
            font.capitalization: Font.AllLowercase
            x: (add_player.width - button.width) / 2
            highlighted: false
        }
        Rectangle {
            id: rectangle1
            width: 180
            height: 45
            x: (add_player.width - button.width) / 2
            y: 108
            color: "#e8e6e4"
            TextInput {
                id: textInput
                x: 7
                maximumLength: 115
                width: 165
                height: 45
                clip: true
                color: "#392c2c"
                text: qsTr("Text Input")
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 14
            }
        }
    }
}
