import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtQml 2.12

import QtQuick.Layouts 1.3
import io.qt.examples.gameutils 1.0
import QtQuick.Controls.Material 2.0

import "logic.js" as Logic
import "graphic.js" as Graphic
ApplicationWindow {

    Component.onCompleted: {
        Logic.create_table(l_board, black_unit_indices, white_unit_indices)
        load.source = "game_form.qml"
    }


    GameUtils{
        id:gameutil
    }

    id: main

    visible: true
    title: qsTr("Chess game")
    height: 454
    color: "#211e1e"
    width: 492


    Material.theme: Material.Dark
    Material.accent: Material.BlueGrey

    property int dropped_ind: -1
    property int grabbed_ind: -1

    property bool is_dropped: false

    property var players : []
    property var game : []


    // These arrays contain indices of chess pieces of their color.
    // Index is -1 if the piece is taken out.
    // id -> index, which id is the initial index of the chess piece.
    property var white_unit_indices : []
    property var black_unit_indices : []

    // game board
    property var l_board: []


    property int player_turn : 1
    property var starter : "black"
    property int b_king_pos : 4
    property int w_king_pos : 60
    property int threatened_king : -1


    Loader{
        id: load
    }



}



