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

// TO-DO scalabillity
// TO-DO Optional starter-color
Window {
    id: main
    color: "black"
    visible: true
    title: qsTr("Chess game")
    height: 454
    width: 384
    property int dropped_ind: -1
    property int grabbed_ind: -1
    property bool is_dropped: false
    property var l_board:  Logic.create_table()
    property var players: Logic.create_player()
    property string last_move
    property int player_turn : 0
    property var starter : "white"
    property int b_king_pos
    property int w_king_pos
    property int threatened_king : -1
    property var danger_zone : []
    property var white_unit_indices : [16]
    property var black_unit_indices : [16]


    GridLayout {
        id: maingrid
        width: parent.width
        height: parent.height
        /* Rectangle{
            visible: false
            Layout.fillHeight: true
            Layout.fillWidth:  true
            Layout.row : 0
            Layout.column: 1

            color: "white"

            Item{
                width: parent.width
                height: parent.height

                Rectangle{
                    id:rightMenu
                    height: parent.height
                    color: "#070909"
                    width:parent.width
                    Text{
                        text:players[1].name
                        font.pixelSize: 20
                        font.bold: true
                        y:10 + this.height
                        color: "#20caca"
                        x:10
                    }
                    Text{

                        text:players[0].name
                        font.pixelSize: 20
                        font.bold: true
                        y:parent.height - this.height - 10
                        color: "#a12a2a"
                        x:10

                    }
                }
            }
        }

        */
        ColumnLayout{
            spacing: 4.7
            Layout.row: 0
            Layout.column:  0
            Rectangle{
                y: 0
                width: 384
                height: 30
                visible:  true
                Layout.fillHeight: false
                Layout.fillWidth: false
                opacity: 0.5
                color: "#20caca"
                transformOrigin: Item.Top
                z: 1


                ListView {
                    id: top_bar
                    x: 8
                    y: 5
                    width: 368
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
                            padding: 2
                        }
                        spacing: 4
                    }
                    model: black_last_5_moves
                    interactive: false
                }

                Flow {
                    id: flow_top
                    x: 0
                    width: 384
                    height: 30
                    enabled: true
                    spacing: 3
                    leftPadding: 4
                    visible: true
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
                    hoverEnabled: true

                    // for reseting previous visited cell color to normal
                    property  int  prev_x: -1
                    property int prev_y: -1


                    onReleased: {
                        dropped_ind = bg_grid.indexAt(mouseX, mouseY)
                        var dropped_cell = grid16.itemAt(mouseX, mouseY)

                        if(Logic.try_move(grabbed_ind, dropped_ind)){
                            dropped_cell.src = ""
                            Graphic.add_last_move()
                            // transition in graphical board
                            Graphic.move(grabbed_ind, dropped_ind)
                        }
                    }

                    onPressed: {

                        dropped_ind = -1
                        grabbed_ind = grid16.indexAt(mouseX, mouseY)

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
                        property string cl : Graphic.cell_color(number)

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
                        // duration looks more on android, needs to be adjusted \(-_-)/
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
                width: 384
                height: 30
                color: "#a12a2a"
                transformOrigin: Item.Top
                opacity: 0.5
                visible: true
                ListView {
                    id: bottom_bar
                    x: 8
                    y: 5
                    width: 368
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

                Flow {
                    id: flow_bottom
                    width: 384
                    height: 30
                    spacing: 5
                    leftPadding: 4
                    visible: true
                    rightPadding: 4
                    topPadding: 5
                }


                z: 1
                Layout.fillWidth: false
                Layout.fillHeight: false
            }




        }
    }

}

