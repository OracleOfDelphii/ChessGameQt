import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import io.qt.examples.gameutils 1.0
import "graphic.js" as Graphic
import "logic.js" as Logic
import "."


Rectangle{

    id: mainMenu
    color: "Black"
    width: main.width
    height: main.height

    Column {
        id: panel
        x: 0
        y: 5
        width: parent.width
        height: parent.height
        spacing: 1


        Button {

            width: parent.width - 20
            height: 60
            id: button0
            highlighted: true
            Material.accent: Material.Red
            text: qsTr("Reset")
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                console.log(JSON.stringify(game))
                game.resetGame()
                grabbed_ind = -1
                dropped_ind = -1
                threatened_king = -1
                b_king_pos = 4
                w_king_pos = 60
                player_turn = 0
                is_dropped = false
                black_last_5_moves.clear()
                white_last_5_moves.clear()

                boardModel.clear()
                bgModel.clear()
                for(var i = 0; i < 64; i++){
                    bgModel.append({"number": i ,
                                       "bcolor": Graphic.cell_color(i)})
                    boardModel.append({"unit_at_i": Global.l_board[i]})
                }

            }
        }

        Button {
            width: parent.width - 20
            height: 60
            id: button1

            text: qsTr("New")
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true
            onClicked: {

                Logic.create_game("P1", "P2")
                load.source= "GameForm.qml"
            }

        }
        Button {

            width: parent.width - 20
            height: 60
            id: button2
            text: qsTr("Load")
            anchors.horizontalCenter: parent.horizontalCenter
            flat: false
            highlighted: true
            onClicked: {
                Global.game.loadGame("newGame.json")
                load.source= "GameForm.qml"
                boardModel.clear()
                bgModel.clear()

                for(var i = 0; i < 64; i++){
                    bgModel.append({"number": i ,
                                       "bcolor": Graphic.cell_color(i)})
                    boardModel.append({"unit_at_i": Global.l_board[i]})
                }

            }
        }

        Button {

            width: parent.width - 20
            height: 60
            id: button3
            text: qsTr("Save")
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true

            onClicked: {

            }
        }

        Button {

            width: parent.width - 20
            height: 60
            id: button4
            text: qsTr("About")
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: false

        }
    }
}
