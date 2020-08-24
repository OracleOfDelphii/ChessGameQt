import QtQuick 2.9
import QtQuick.Controls 2.12
import QtQuick.Window 2.2
import QtQml 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.0

import io.qt.examples.gameutils 1.0

import "logic.js" as Logic
import "graphic.js" as Graphic
ApplicationWindow {
    id: main

    GameUtils{
        id: gameutil
    }

    Component.onCompleted: {
        Logic.create_table(Global.l_board,
                           Global.black_unit_indices,
                           Global.white_unit_indices)
        Global.game = Logic.create_game("player1","player2")
        load.source = "MainMenu.qml"
        console.log(JSON.stringify(players))
    }

    property int dropped_ind: Global.dropped_ind
    property int grabbed_ind: Global.grabbed_ind

    property bool is_dropped: Global.is_dropped

    property var players : Global.players
    property var game: Global.game
    property string winner: Global.winner

    // These arrays contain indices of chess pieces of their color.
    // Index is -1 if the piece is taken out.
    // id -> index, which id is the initial index of the chess piece.
    property var white_unit_indices : Global.white_unit_indices
    property var black_unit_indices : Global.black_unit_indices

    // game board
    property var l_board: Global.l_board

    property int player_turn : Global.player_turn
    property var starter : Global.starter
    property int b_king_pos : Global.b_king_pos
    property int w_king_pos : Global.w_king_pos
    property int threatened_king : Global.threatened_king

    visible: true
    title: qsTr("Chess game")
    height: 454
    color: "#211e1e"
    width: 492

    Material.theme: Material.Light
    Material.accent: Material.Grey



    ListModel{
        id: boardModel
        Component.onCompleted: {

            for(var i = 0; i <= 63; i++){
                append({"unit_at_i": Global.l_board[i]})
            }
        }

    }

    ListModel {
        id: bgModel
        Component.onCompleted: {
            for(var i = 0; i <= 63; i++){
                append({"number": i ,
                           "bcolor": Graphic.cell_color(i)})
            }
        }
    }

    ListModel {
        id: black_last_5_moves
    }
    ListModel {
        id: white_last_5_moves
    }

    Loader{

        id: load
    }

}



