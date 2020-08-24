import QtQuick 2.0
import QtQuick.Particles 2.0
import QtQuick.Controls 2.1

// This is an edited version of QT particle example.


Pane{
    id: pane
    width: 360
    height: 340
    background: Rectangle {
        id: g_result
         anchors.fill: parent
        color: "#000000"
        Text {
            id: winner_name
            color: "#ffffff"
            text: game.winner.name
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 25
            horizontalAlignment: Text.AlignHCenter
        }

        Text {
            id: element1
            color: "#ffa500"
            text: qsTr("Won!")
            anchors.verticalCenterOffset: 35
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 25
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Button {
            id: button
            width: 120
            height: 50

            text: qsTr("main menu")
            highlighted: true
            anchors.verticalCenterOffset: -50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.bottom

            onClicked: {
                load.source = "MainMenu.qml"
            }
        }
    }



    ParticleSystem { id: particles
        visible:  true
    }

    ImageParticle {
        color: "#ffffff"
        system: particles
        colorVariation: 0.5
        alpha: 0


        source: "images/w_king.png"
        colorTable: "images/colortable.png"
        sizeTable: "images/b_soldier.png"

    }

    Emitter {
        system: particles
        emitRate: 600
        lifeSpan: 3000

        y: g_result.height / 2 + Math.sin(t) * g_result.height * 0.3
        x: g_result.width / 2 + Math.cos(t) * g_result.width * 0.3
        property real t;

        NumberAnimation on t {
            from: 0; to: Math.PI * 2; duration: 8000; loops: Animation.Infinite
        }

        velocityFromMovement: 25

        velocity: PointDirection { xVariation: 5; yVariation: 5;}
        acceleration: PointDirection { xVariation: 5; yVariation: 5;}

        size: 16
        //endSize: 8
        //sizeVariation: 8
    }


}






/*##^##
Designer {
    D{i:2;anchors_x:1;anchors_y:89}
}
##^##*/
