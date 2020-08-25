import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15

Rectangle{
    width: screen.width
    height: screen.height
    color: "#bebcbc"
    Image {
        id: name
        width: screen.width

        source: "images/about.png"
    }
    Button {
        id: button
        width: 120
        height: 50

        text: qsTr("main menu")
        highlighted: true
        anchors.verticalCenterOffset: 120
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        onClicked: {
            load.source = "MainMenu.qml"
        }
    }
}


