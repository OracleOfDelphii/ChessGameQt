import QtQml.Models 2.3
import QtQuick.Window 2.2
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12

import "graphic.js" as Graphic
import "logic.js" as Logic

/*
 The graphic has three parts so far:
    grid for units
    grid for background
    two Flow layouts for additional things(movements, score, ...)
*/

// problem with rotation, either turn off rotation or make it responsive

// To-Do rotation + starter(default white)

Window {
    id: main
    color: "black"
    visible: true
    title: qsTr("Chess game")
    width: 8 * 48
    height: 454

    property int _ind: 0;
    property int dropped_ind: 0;
    property int grabbed_ind: 0;
    property bool is_dropped: false
    property var l_board:  Logic.create_table()
    property var players: Logic.create_player()

    property string last_move

    property int player_turn : 0
    property var starter : "white"


    property int b_king_pos
    property int w_king_pos
    property QtObject b_king_bg
    property QtObject w_king_bg
    property int threatened_king : -1

    // better idea
    property int b_king_id
    property int w_king_id
    //



    property var white_unit_indices : [16]
    property var black_unit_indices : [16]


    ColumnLayout{

        Rectangle{
            id: last_moves_container
            y: 0
            width: 384
            height: 30
            visible:  true
            Layout.fillHeight: false
            Layout.fillWidth: false
            opacity: 0.5
            color: "#e49292"
            transformOrigin: Item.Top
            z: 1

            Flow {
                id: element1
                x: 0
                width: 384
                height: 30
                leftPadding: 4
                visible: true
                ListView {
                    id: top_bar
                    x: 0
                    y: 0
                    width: 384
                    height: 30
                    contentHeight: 0
                    orientation: ListView.Horizontal
                    visible: true
                    spacing: 8
                    delegate: Flow {
                        Image {
                            width: 16
                            height: 16
                            fillMode: Image.PreserveAspectFit
                            source: src
                        }

                        Text {
                            color: ucolor
                            text: mv
                            font.pixelSize: 15
                            font.bold: true
                        }
                        spacing: 4
                    }
                    model: black_last_5_moves
                    interactive: false
                }
                rightPadding: 4
                topPadding: 5
            }

        }

        Item{
            id: game_area
            y: 30
            height: 384
            MouseArea{
                rotation: 0
                id: marea
                z:1
                width: 8 * 48
                height: 8 * 48
                // on desktop hover works, on android there is no hover
                hoverEnabled: true
                // for reseting previous visited cell color to normal
                property  int  prev_x: -1
                property int prev_y: -1

                onReleased: {

                    dropped_ind = bg_grid.indexAt(mouseX, mouseY)
                    if(dropped_ind !== threatened_king){
                        bgModel.set(dropped_ind, {"bcolor": "Purple"})
                        console.log(dropped_ind + " " + threatened_king + "EEE")
                    }
                    var dropped_unit = grid16.itemAt(mouseX, mouseY)
                    var start_unit = l_board[grabbed_ind]
                    var cl = player_turn === 0 ? "white" : "black"
                    var op_cl = player_turn === 0 ? "black" : "white"
                    var prev_threatened_king = threatened_king
                    var op_threated = -1

                    if(start_unit.ucolor === cl){

                        if(Logic.is_valid_mv(grabbed_ind, dropped_ind, l_board)){
                            threatened_king = Logic.is_check(grabbed_ind, dropped_ind, l_board, cl)
                            if(threatened_king === -1){
                                op_threated = Logic.is_check(grabbed_ind, dropped_ind, l_board, op_cl)

                                if(prev_threatened_king !== -1){
                                    bgModel.set(prev_threatened_king, {"bcolor": Graphic.cell_color(prev_threatened_king)})
                                }

                                if(l_board[grabbed_ind].ucolor === "white"){
                                    white_unit_indices[l_board[grabbed_ind].id] =  dropped_ind
                    console.log(threatened_king + " " + grabbed_ind + "::")                }
                                if(l_board[grabbed_ind].ucolor === "black"){
                                    black_unit_indices[l_board[grabbed_ind].id] = dropped_ind
                                }

                                l_board[grabbed_ind].index = l_board[dropped_ind].index
                                l_board[dropped_ind]  = l_board[grabbed_ind]
                                l_board[grabbed_ind] = Logic.empty_unit(grabbed_ind)

                                if(grabbed_ind === b_king_pos){
                                    b_king_pos = dropped_ind
                                }
                                if(grabbed_ind === w_king_pos){
                                    w_king_pos = dropped_ind
                                }

                                dropped_unit.src = ""
                                Graphic.add_last_move()
                                players[player_turn].inc_mv_num()
                                if(player_turn == 0){
                                    player_turn = 1
                                }
                                else{
                                    player_turn = 0
                                }
                                if( grabbed_ind < dropped_ind){
                                    boardModel.move(grabbed_ind, dropped_ind, 1)
                                    boardModel.move(dropped_ind - 1, grabbed_ind, 1)
                                }
                                else{
                                    boardModel.move(dropped_ind, grabbed_ind, 1)
                                    boardModel.move(grabbed_ind - 1, dropped_ind, 1)
                                }

                            }

                        }

                        if(op_threated === -1 && threatened_king === -1){
                            bgModel.set(w_king_pos, {"bcolor":  Graphic.cell_color(w_king_pos)  })
                            bgModel.set(b_king_pos, {"bcolor":  Graphic.cell_color(b_king_pos)  })
                        }
                        else if(op_threated !== -1){
                            bgModel.set(op_threated, {"bcolor":  "Orange"  })
                            threatened_king = op_threated
                        }
                    }
                }

                onPressed: {
                    if(grabbed_ind !== threatened_king)
                        bgModel.set(grabbed_ind, {"bcolor": Graphic.cell_color(grabbed_ind)})
                    if(dropped_ind !== threatened_king)
                        bgModel.set(dropped_ind, {"bcolor": Graphic.cell_color(dropped_ind)})
                    grabbed_ind = grid16.indexAt(mouseX, mouseY)
                    if(grabbed_ind !== threatened_king){
                        bgModel.set(grabbed_ind, {"bcolor":  "Purple"  })

                    }
                        if(l_board[grabbed_ind].ucolor === "white"){
                        white_unit_indices[l_board[grabbed_ind].id] =  grabbed_ind
                    }
                    if(l_board[grabbed_ind].ucolor === "black"){
                        black_unit_indices[l_board[grabbed_ind].id] = grabbed_ind
                    }
                }

            }

            GridView{
                rotation: 0
                id: bg_grid
                cellWidth:  48
                cellHeight: 48
                interactive:  false
                model: bgModel
                width: 8 * 48
                height: 8 * 48
                delegate:
                    Item{
                    id: cell_bg
                    width: 48
                    height: 48
                    property string cl : bcolor

                    Rectangle{
                        z: 0
                        width: 48
                        height: 48
                        color: cl
                    }
                }
            }

            GridView {
                width: 8 * 48
                height: 8 * 48
                interactive: false
                id: grid16;
                cellWidth: 48
                cellHeight: 48
                rotation: 0
                model: boardModel

                delegate:
                    Units{
                    index: 63
                    src: Graphic.unit_src(l_board[number].index)
                    rotation: 0
                    is_white: l_board[number].ucolor === "white"
                }

                move: Transition {
                    // duration looks more on android \(-_-)/
                    NumberAnimation { properties: "x,y"; duration: 125 }
                }
            }

            ListModel {
                id: boardModel
                Component.onCompleted: {
                    for(var i = 0; i <= 63; i++){
                        append({"number": i})
                    }
                }
            }

            ListModel {
                id: bgModel
                Component.onCompleted: {
                    for(var i = 0; i <= 63; i++){
                        append({"number": i , "bcolor": Graphic.cell_color(i)})
                    }
                }
            }

            ListModel {
                id: black_last_5_moves
            }
            ListModel {
                id: white_last_5_moves
            }


        }

        Rectangle {
            id: bottom_bar
            width: 384
            height: 30
            color: "#a52a2a"
            transformOrigin: Item.Top
            opacity: 0.5
            visible: true
            Flow {
                id: element2
                x: 0
                width: 384
                height: 30
                leftPadding: 4
                visible: true
                ListView {
                    x: 0
                    y: 0
                    width: 384
                    height: 30
                    orientation: ListView.Horizontal
                    visible: true
                    spacing: 8
                    contentHeight: 0
                    delegate: Flow {
                        Image {
                            width: 16
                            height: 16
                            fillMode: Image.PreserveAspectFit
                            source: src
                        }

                        Text {
                            color: ucolor
                            text: mv
                            font.pixelSize: 15
                            font.bold: true
                        }
                        spacing: 4
                    }
                    model: white_last_5_moves
                    interactive: false
                }
                rightPadding: 4
                topPadding: 5
            }
            z: 1
            Layout.fillWidth: false
            Layout.fillHeight: false
        }

    }
}

