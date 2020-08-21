import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.12
import "graphic.js" as Graphic
import "logic.js" as Logic
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
import QtQml 2.12
import io.qt.examples.gameutils 1.0
import QtQuick.Controls.Material 2.0

Item{
    id: game_item
    GridLayout {


        id: maingrid
        width: parent.width
        height: parent.height

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
                width: 384
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
                        var move_state =
                                Logic.try_move(l_board,
                                               grabbed_ind, dropped_ind);
                        if(move_state !== 0){
                            dropped_cell.src = ""
                            Graphic.add_last_move()
                            // transition in graphical board
                            Graphic.move(grabbed_ind, dropped_ind)
                        }
                        else if(move_state === -1){
                            Graphic.add_last_move()
                        }



                    }

                    onPressed: {

                        dropped_ind = -1
                        grabbed_ind = grid16.indexAt(mouseX, mouseY)

                        if(l_board[grabbed_ind].ucolor === "white"){

                            white_unit_indices[l_board[grabbed_ind].id] =
                                    grabbed_ind
                        }
                        if(l_board[grabbed_ind].ucolor === "black"){

                            black_unit_indices[l_board[grabbed_ind].id] =
                                    grabbed_ind
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

                GridView{
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
                        src:
                            Graphic.unit_src(l_board[number].index)
                        rotation: 0
                        is_white: l_board[number].ucolor === "white"
                    }

                    move: Transition{
                        // duration looks more on android,
                        //needs to be adjusted \(-_-)/
                        NumberAnimation{ properties: "x,y"; duration: 125 }
                    }
                }

                ListModel{
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
        visible: true
        dragMargin: main.width - game_area.width - 5

        y: 0
        Column {

            id: right_panel
            x: 0
            y: 5
            width: drawer.width
            height: 203
            spacing: 1

            Button {
                width: drawer.width - 20
                height: 60
                id: button1
                highlighted: false
                text: qsTr("New")
                anchors.horizontalCenter: parent.horizontalCenter

                onClicked: {

                    Logic.create_game()
                    Add_playerForm.visible = true

                }

            }
            Button {

                width: drawer.width - 20
                height: 60
                id: button2
                text: qsTr("Load")
                anchors.horizontalCenter: parent.horizontalCenter
                flat: false
                highlighted: false
            }

            Button {
                width: drawer.width - 20
                height: 60
                id: button3
                text: qsTr("Save")
                anchors.horizontalCenter: parent.horizontalCenter
                highlighted: false
            }

            Button {
                width: drawer.width - 20
                height: 60
                id: button4
                text: qsTr("About")
                anchors.horizontalCenter: parent.horizontalCenter
                highlighted: false
            }
        }
    }

}
