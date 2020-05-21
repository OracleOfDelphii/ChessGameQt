import QtQml.Models 2.3
import QtQuick.Window 2.2
import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12

import "graphic.js" as Graphic
import "logic.js" as Logic

// needs refactor, seperate ui from logic
/*
 The graphic has three parts so far:
    grid for units
    grid for background
    A row for additional things(like score, ...)
    grid for background is almost static, it can only change color when units are being moved
    grid for units is dynamic
*/

// problem with rotation, either turn off rotation or make it responsive
// fix anything that is hard-coded

// To-Do rotation + starter(default white)

Window {
    id: main
    color: "black"
    visible: true
    title: qsTr("Chess game")
    width: 8 * 48
    height: 8 * 48  +  40

    property int _ind: 0;
    property int dropped_ind: 0;
    property int grabbed_ind: 0;
    property bool is_dropped: false
    property var l_board:  Logic.create_table()
    property var players: Logic.create_player()

    property string last_move

    property int player_turn : 0
    property var starter : "white"


    ColumnLayout{

        Rectangle{
            id: last_moves_container
            width: 384
            height: 30
            visible:  true
            Layout.fillHeight: false
            Layout.fillWidth: false
            opacity: 0.5
            color: "brown"
            transformOrigin: Item.Top
            z: 1


            Flow {
                id: element
                width: 400
                height: 400

                leftPadding: 4
                rightPadding: 4
                topPadding: 5
                // suggestion: dedicate a last_5_move for each player
                ListView{
                    width: 384
                    height: 30
                    orientation: ListView.Horizontal
                    interactive:  false
                    spacing: 8
                    visible:  true
                    model: last_5_moves
                    delegate:
                        Flow{
                        spacing: 4
                        Image {
                            width: 16
                            height: 16
                            source: src
                            fillMode: Image.PreserveAspectFit
                        }
                        Text {
                            text:  mv
                            font.bold: true
                            font.pixelSize: 15
                            color : ucolor
                        }
                    }
                }
            }
        }

        Item{
            y: last_moves_container.height
            id: game_area
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
                    var dropped_unit = grid16.itemAt(mouseX, mouseY)
                    if(Logic.is_valid_mv(grabbed_ind, dropped_ind)){

                        l_board[grabbed_ind].index = dropped_ind
                        l_board[dropped_ind]  = l_board[grabbed_ind]
                        l_board[grabbed_ind] = Logic.empty_unit(grabbed_ind)
                        dropped_unit.src = ""
                        Graphic.add_last5_move()
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

                onPressed: {

                    grabbed_ind = grid16.indexAt(mouseX, mouseY)
                }

                onPositionChanged: {
                 /*    // index of previous visited cell(hover)
                    if(prev_x != -1 && prev_y != -1){
                        var prev_cell = bg_grid.itemAt(prev_x, prev_y)
                        var prev_index = bg_grid.indexAt(prev_x, prev_y)
                        if( typeof(prev_cell) !== "null"){
                            if(prev_cell !== grabbed_ind){
                                prev_cell.cl = Graphic.cell_color(prev_index)
                            }

                            if(bg_grid.indexAt(marea.mouseX,marea.mouseY) !== grabbed_ind) {
                                bg_grid.itemAt(marea.mouseX,marea.mouseY).cl = "Blue"
                                // bug on android since there is no hover
                            }
                        }
                    }
                    prev_x = mouseX
                    prev_y = mouseY
 */
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
                    property string cl
                    Component.onCompleted: {
                        cl = Graphic.cell_color(number)
                    }

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
                    index: number
                    src: Graphic.unit_src(l_board[number].index)
                    rotation: 0
                    is_white: l_board[number].ucolor === "white"
                }

                move: Transition {
                    // duration looks more on android \(-_-)/
                    NumberAnimation { properties: "x,y"; duration: 250 }
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
                        append({"number": i})
                    }
                }
            }

            ListModel {
                id: last_5_moves
            }
        }
    }
}

