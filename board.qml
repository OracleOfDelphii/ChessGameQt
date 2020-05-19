import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
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
Window {
    id: main
    color: "black"
    visible: true
    title: qsTr("Chess game")
    width : 8 * 48
    height : 8 * 48  +  40

    property int _ind : 0;
    property int dropped_ind : 0;
    property int grabbed_ind : 0;
    property bool is_dropped : false
    property var l_board : [[]]
    property var turn : 0


    Component.onCompleted : {
        l_board = Logic.create_table()
    }

    ColumnLayout{
        Layout.fillHeight: true

        Layout.fillWidth:  true

        RowLayout{
            Layout.alignment: Qt.AlignVCenter | Qt.AlignLeft
            height: 40
            LayoutMirroring.childrenInherit: true
            LayoutMirroring.enabled: true

            Rectangle{
                visible:  true
                Layout.fillHeight: true
                Layout.fillWidth: true

                color: "Orange"

                Label{
                    color:"black"


                    padding: 2
                    text:"Score: 0"
                    visible: true
                    font.bold : true

                    font.family: "IRANSans"

                }
            }
        }

        Item{
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter


            width : 8 * 48
            height : 8 * 48 + 40
            id: game_area
            y:40

            MouseArea{

                id: marea
                z:1
                anchors.fill: parent
                hoverEnabled: true
                property color cl
                property int mode : 0
                property  int  prev_x : -1
                property int prev_y : -1
                property QtObject gcell
                property QtObject dcell
                property QtObject gunit
                property QtObject dunit

                onReleased: {

                }

                onPressed: {
                    /*
                   if mode == 0 : player 1 is still choosing
                   if mode == 1 : player 2 is going to choose
                   if mode == 2 : no one is choosing, no action this time
                */

                    /*
                    blue is hover( incomplete for android since there is no hover)
                    purple is player 1
                  */

                    // problem: player doesn't have a chance to change movement/cancel
                    // if movement was illegal, cancel it!

                    if(mode == 2){
                        mode = 0
                    }
                    if(mode == 1){
                        dcell = bg_grid.itemAt(marea.mouseX,marea.mouseY)
                        dunit = grid16.itemAt(marea.mouseX,marea.mouseY)
                        if(gunit !== dunit){
                            if(dunit === grid16.itemAt(marea.mouseX,marea.mouseY)) {
                                main.dropped_ind = grid16.indexAt(marea.mouseX,marea.mouseY)
                                z = -1
                                if( grabbed_ind < dropped_ind){
                                    gridModel.move(grabbed_ind, dropped_ind, 1)
                                    gridModel.move(dropped_ind - 1, grabbed_ind, 1)
                                }
                                else{
                                    gridModel.move(dropped_ind, grabbed_ind, 1)
                                    gridModel.move(grabbed_ind - 1, dropped_ind, 1)
                                }
                                mode++
                                gcell.cl = Graphic.cell_color(grabbed_ind)
                            }
                        }
                        else{
                            mode = 0;
                            gcell.cl = Graphic.cell_color(grabbed_ind)
                        }
                    }
                    else if(mode == 0){
                        gcell = bg_grid.itemAt(marea.mouseX,marea.mouseY)
                        gunit = grid16.itemAt(marea.mouseX,marea.mouseY)
                        if(gunit.src !== ""){

                            main.grabbed_ind = grid16.indexAt(marea.mouseX,marea.mouseY)
                            cl = bg_grid.itemAt(marea.mouseX,marea.mouseY).cl
                            bg_grid.itemAt(marea.mouseX,marea.mouseY).cl = "Purple"
                            mode++;
                        }
                    }

                }

                onPositionChanged: {
                    var index = bg_grid.indexAt(prev_x, prev_y)
                    if(index >= 0 && index <= 63){
                        if(bg_grid.indexAt(prev_x, prev_y) !== grabbed_ind)
                            bg_grid.itemAt(prev_x, prev_y).cl = Graphic.cell_color(index)
                        if(bg_grid.indexAt(marea.mouseX,marea.mouseY) !== grabbed_ind)
                            bg_grid.itemAt(marea.mouseX,marea.mouseY).cl = "Blue"
                        // bug on android since there is no hover
                    }
                    prev_x = mouseX
                    prev_y = mouseY
                }
            }

            GridView{
                id: bg_grid
                anchors.centerIn: parent
                cellWidth:  48
                cellHeight: 48
                interactive:  false

                anchors.fill: parent

                model: bgModel


                delegate:

                    Item{
                    id: cell_bg
                    width:48
                    height:48
                    property string cl : Graphic.cell_color(index)
                    Rectangle{
                        z : 0
                        width : 48
                        height : 48
                        color : cl

                    }
                }
            }




            GridView {
                interactive:  false
                id: grid16;
                anchors.fill: parent
                cellWidth:  48
                cellHeight: 48
                model: gridModel

                delegate:
                    Units{
                    index: Graphic.set_index()
                }

                move: Transition {
                    NumberAnimation { properties: "x,y"; duration: 250
                    }
                }
            }

            ListModel {
                id: gridModel
                Component.onCompleted: {
                    for(var j= 0; j < 64; j++){
                        gridModel.append(Units)
                    }
                }

            }

            ListModel {
                id: bgModel

                Component.onCompleted: {
                    for(var j= 0; j < 64; j++){
                        bgModel.append(Units)
                    }
                }

            }
        }
    }
}
