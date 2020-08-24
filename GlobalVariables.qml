pragma Singleton
import QtQuick 2.0

QtObject {
    property int dropped_ind: -1
    property int grabbed_ind: -1

    property bool is_dropped: false

    property var players : []
    property var game;

    property string winner: ""

    // These arrays contain indices of chess pieces of their color.
    // Index is -1 if the piece is taken out.
    // id -> index, which id is the initial index of the chess piece.
    property var white_unit_indices : []
    property var black_unit_indices : []

    // game board
    property var l_board: []

    property int player_turn : 0
    property var starter : "black"
    property int b_king_pos : 4
    property int w_king_pos : 60
    property int threatened_king : -1

}
