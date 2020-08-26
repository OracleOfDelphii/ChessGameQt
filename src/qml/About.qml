import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.0
Rectangle{

    width: main.width
    height: main.height
    color: "#e6f3ff"
    Column{
        anchors.horizontalCenter: parent.horizontalCenter
        y: main.height * 0.05
        spacing: 5
        width: 100

            Text{
                color:"#232020"
                font.pointSize: 20
                anchors.horizontalCenter: parent.horizontalCenter
                 textFormat: Text.RichText
                height: 70
                text: "<span>made with</span><span style=\"font-size: 40pt;color:#9e331e\">❤</span>"
            }


        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            textFormat: Text.RichText
            font.pointSize: 12
            text: "<a href=\"https://github.com/ariaman5/ChessGameQt\">project github</a>"
            onLinkActivated:  Qt.openUrlExternally(link)
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 6
            textFormat: Text.RichText
            text: "Technologies used: Qt Quick, C++, Js"

        }

    }

    Button {
        anchors.horizontalCenter: parent.horizontalCenter
        id: button
        width: 120
        height: 50

        text: qsTr("main menu")
        highlighted: true
        anchors.verticalCenterOffset: 120
        anchors.verticalCenter: parent.verticalCenter

        onClicked: {
            load.source = "MainMenu.qml"
        }
    }
}


