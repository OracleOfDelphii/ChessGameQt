import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtQml 2.12
import Global 1.0
import QtQuick.Layouts 1.3
import gameutils 1.0
import QtQuick.Controls.Material 2.0


import "../js/graphic.js" as Graphic
import "../js/logic.js" as Logic

Item{
    id: game_form
    GridLayout {

        id: maingrid

        height: 8 * Math.min(main.width/4,48)

        width: 8 * Math.min(main.width/4,48)
        ColumnLayout{
            spacing: 4.7
            Layout.row: 0
            Layout.column:  0
            Rectangle{
                y: 0
                width: 8 * Math.min(main.width/4,48)
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
                    width: parent.width
                    height: 30

                    orientation: ListView.Horizontal
                    visible: true
                    spacing: 7
                    delegate: Flow {
                        Image {
                            width:  Math.min(main.width /12, 16)
                            height: Math.min(main.width /12, 16)
                            fillMode: Image.PreserveAspectFit
                            source: src
                        }

                        Text {
                            color: ucolor
                            text: mv
                            font.pointSize: 12
                            font.bold: true
                            padding: 2
                        }
                        spacing: 4
                    }
                    model: Global.black_last_5_moves
                    interactive: false
                }

                Flow {
                    id: flow_top
                    x: 0
                    width: 8 * Math.min(main.width/4,48)
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
                height: 8 * Math.min(main.width/4,48)
                width: 8 * Math.min(main.width/4,48)
                MouseArea{
                    rotation: 0
                    id: marea
                    z:1
                    width: 8 * Math.min(main.width/4,48)
                    height: 8 * Math.min(main.width/4,48)
                    hoverEnabled: true

                    // for reseting previous visited cell color to normal
                    property  int  prev_x: -1
                    property int prev_y: -1


                    onReleased: {
                        Global.dropped_ind = bg_grid.indexAt(mouseX, mouseY)
                        var dropped_cell = grid16.itemAt(mouseX, mouseY)
                        var move_state =
                                Logic.try_move(Global.l_board, Global.black_unit_indices,
                                               Global.white_unit_indices,
                                               Global.grabbed_ind, Global.dropped_ind);
                        if(move_state !== 0){
                            dropped_cell.src = ""
                            Graphic.add_last_move()
                            // transition in graphical board

                            Graphic.move(Global.grabbed_ind, Global.dropped_ind)
                            if(move_state === -1){
                                Graphic.add_last_move()
                                var info = {"type": "normal",
                                    "start": "white",
                                    "turn": Global.game.turn,
                                    "winner": Global.game.winner}
                                Global.game.saveGame("1.json", Global.players,
                                                     Global.l_board, info)
                                load.source = "GameResult.qml"
                            }
                        }




                    }

                    onPressed: {

                        Global.dropped_ind = -1
                        Global.grabbed_ind = grid16.indexAt(mouseX, mouseY)

                        if(Global.l_board[Global.grabbed_ind].cl === "white"){

                            Global.white_unit_indices[Global.l_board[Global.grabbed_ind].id] =
                                    Global.grabbed_ind
                        }
                        if(Global.l_board[Global.grabbed_ind].cl === "black"){

                            Global.black_unit_indices[Global.l_board[Global.grabbed_ind].id] =
                                    Global.grabbed_ind
                        }
                    }

                }

                GridView{
                    rotation: 0

                    id: bg_grid
                    cellWidth: Math.min(main.width/8,48)
                    cellHeight: Math.min(main.width/8,48)
                    interactive:  false
                    model: bgModel
                    width: 8 * this.cellWidth
                    height: 8 * this.cellHeight
                    delegate:
                        Item{
                        id: cell_bg
                        width: Math.min(main.width/4,48)
                        height: Math.min(main.width/4,48)
                        property string cl : Graphic.cell_color(number)

                        Rectangle{
                            z: 0
                            width: Math.min(main.width/4,48)
                            height:Math.min(main.width/4,48)
                            color: cl
                        }
                    }
                }

                GridView{
                    width: 8 * this.cellWidth
                    height: 8 * this.cellHeight
                    interactive: false
                    id: grid16;
                    cellWidth: Math.min(main.width/8,48)
                    cellHeight: Math.min(main.width/8,48)
                    rotation: 0
                    model: Global.boardModel

                    delegate:
                        Units{
                        index: 63
                        src: Graphic.unit_src(unit_at_i)
                        rotation: 0
                        is_white: unit_at_i.cl === "white"
                    }

                    move: Transition{
                        // duration looks more on android,
                        //needs to be adjusted \(-_-)/
                        NumberAnimation{ properties: "x,y"; duration: 125 }
                    }
                }

            }

            Rectangle {
                width: 8* Math.min(main.width/4,48)
                height: 30
                color: "#a12a2a"
                transformOrigin: Item.Top
                opacity: 0.5
                visible: true
                ListView {
                    id: bottom_bar
                    x: 8
                    y: 5
                    width: parent.width
                    height: 30
                    orientation: ListView.Horizontal
                    visible: true
                    spacing: 8
                    contentHeight: 0
                    delegate: Flow {
                        Image {
                            width: Math.min(main.width/12, 16)
                            height: Math.min(main.width/12, 16)
                            fillMode: Image.PreserveAspectFit
                            source: src
                        }

                        Text {
                            color: ucolor
                            text: mv
                            font.pointSize: 12
                            font.bold: true
                        }
                        spacing: 4
                    }
                    model: Global.white_last_5_moves
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

    Rectangle {
        id: rectangle
        x: game_area.width + 5
        y: 0
        width: main.width - game_area.width
        height: main.height
        color: "Black"
    }

    Drawer {
        background: Rectangle {
            color: "Black"
            Rectangle {
                x: parent.width - 1
                width: 1
                height: parent.height
                color: "Black"
            }
        }


        id: drawer
        width: main.width
        height:main.height
        edge: Qt.RightEdge
        dragMargin: main.width - game_area.width - 5

        MainMenu{
            id: drawer_menu
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
