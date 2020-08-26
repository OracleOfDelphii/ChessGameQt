import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import Global 1.0
import gameutils 1.0
import "../js/graphic.js" as Graphic
import "../js/logic.js" as Logic


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
            height: Math.min(main.width / 4, 48) + 20
            id: button0
            highlighted: true
            Material.accent: Material.Red
            text: qsTr("Reset")
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                Global.game.resetGame()

                Global.grabbed_ind = -1
                Global.dropped_ind = -1
                Global.threatened_king = -1
                Global.b_king_pos = 4
                Global.w_king_pos = 60
                Global.player_turn = 0
                Global.is_dropped = false
                black_last_5_moves.clear()
                white_last_5_moves.clear()
                Global.l_board = Global.game.board
                Global.black_unit_indices = []
                Global.white_unit_indices = []
                Global.winner = ""

                Global.boardModel.clear()
                Global.bgModel.clear()

                for(var i = 0; i < 64; i++){
                    Global.bgModel.append({"number": i ,
                                              "bcolor": Graphic.cell_color(i)})
                    console.log(JSON.stringify(Global.l_board[i]))
                    Global.boardModel.append({"unit_at_i": Global.l_board[i]})
                }
                load.source= "GameForm.qml"
            }
        }

        Button {
            width: parent.width - 20
            height: Math.min(main.width / 4, 48) + 20
            id: button1

            text: qsTr("New")
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true

            onClicked: {
                Global.game.resetGame()

                // these information should be stored in the file
                Global.grabbed_ind = -1
                Global.dropped_ind = -1
                Global.threatened_king = -1
                Global.b_king_pos = 4
                Global.w_king_pos = 60
                Global.player_turn = 0
                Global.is_dropped = false
                Global.black_last_5_moves.clear()
                Global.white_last_5_moves.clear()
                Global.player_turn = 0
                Global.l_board = Global.game.board
                Global.black_unit_indices = []
                Global.white_unit_indices = []
                Global.winner = ""
                Global.players = []


                Global.boardModel.clear()
                Global.bgModel.clear()

                for(var i = 0; i < 64; i++){
                    Global.bgModel.append({"number": i ,
                                              "bcolor": Graphic.cell_color(i)})
                    Global.boardModel.append({"unit_at_i": Global.l_board[i]})
                }

                Global.game.initNewGame("superman", "batman")
                load.source= "GameForm.qml"
            }

        }
        Button {

            width: parent.width - 20
            height: Math.min(main.width / 4, 48) + 20
            id: button2
            text: qsTr("Load")
            anchors.horizontalCenter: parent.horizontalCenter
            flat: false
            highlighted: true
            onClicked: {
                Global.boardModel.clear()
                Global.bgModel.clear()
                Global.game.loadGame("newGame1.json")
                Global.black_last_5_moves.clear()
                Global.white_last_5_moves.clear()



                for(var i = 0; i < 64; i++){
                    Global.bgModel.append({"number": i ,
                                              "bcolor": Graphic.cell_color(i)})

                    Global.boardModel.append({"unit_at_i": Global.l_board[i]})
                }

                load.source = "GameForm.qml"



            }
        }

        Button {

            width: parent.width - 20
            height: Math.min(main.width/4,48) + 20
            id: button3
            text: qsTr("Save")
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: true

            onClicked: {
                var info = {"type": "normal",
                    "start": "white",
                    "turn": Global.game.turn,
                    "winner": Global.game.winner,
                    "threatened_king": Global.threatened_king,
                    "is_threatened": Global.is_threatened,
                    "b_king_pos": Global.b_king_pos,
                    "w_king_pos": Global.w_king_pos,
                    // "black_last_5_moves": black_last_5_moves,
                    // "white_last_5_moves": white_last_5_moves,
                    "black_unit_indices": Global.black_unit_indices,
                    "white_unit_indices": Global.white_unit_indices
                }

                Global.game.saveGame
                        ("newGame1.json", Global.players, Global.l_board, info)
            }
        }

        Button {

            width: parent.width - 20
            height: Math.min(main.width/4,48) + 20
            id: button4
            text: qsTr("About")
            anchors.horizontalCenter: parent.horizontalCenter
            highlighted: false
            onClicked: {
                load.source = "About.qml"
            }

        }
    }
}
