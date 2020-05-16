import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Layouts 1.3
import "graphic.js" as Graphic
Window {
    id : main
    visible: true
    width: 8 * 64 + 50
    height: 8 * 64 + 50
    title: qsTr("Chess game")
    property int _ind : 0;
    property int dropped_ind : 0;
    property int grabbed_ind : 0;
    property bool is_dropped : false
    GridLayout{
        id: bg_grid
        x:4
        y:4
        rows : 8
        columns: 8
        property alias bg_repeater : bg_repeater;

        Repeater{
            id: bg_repeater
            model : 64
            Item{
                id: cell_bg
                width:64
                height:64
                property string cl : Graphic.cell_color(index)
                Rectangle{
                    z : 0
                    width : 64
                    height : 64
                    color : cl


                    DropArea {
                        anchors.fill: parent
                        id: dragTarget

                        property string cl_prev
                        onContainsDragChanged: {
                            if(containsDrag){
                                console.log(index)
                                cl_prev = cl
                                cl = "Pink"
                            }
                            else{
                                cl =  cl_prev

                            }
                        }

                        onExited: {

                        }

                        onDropped: {
                            console.log("Fuck")


                        }



                    }
                }
            }

        }
    }
    GridLayout{
        z:1
        id: units_grid

        rows: 8

        columns: 8
        property  alias  board: unit_repeater
        Repeater{
            id:unit_repeater
            model: 64

            Item{
                id: cell_unit
                width: 64
                height: 64
                property int  cur_x
                property int  cur_y
                property int  prev_x : unit.x
                property int  prev_y : unit.y
                property  string src :  if((index > 7 && index <= 15)) return "images/w_soldier.png"
                                        else if((index >= 48 && index < 56)) return "images/b_soldier.png"
                                        else{
                                            switch(index){
                                            case 56:
                                                return "images/b_rock.png"
                                            case 57:
                                                return "images/b_horse.png"
                                            case 58:
                                                return "images/b_bishop.png"
                                            case 59:
                                                return "images/b_queen.png"
                                            case 60:
                                                return "images/b_king.png"
                                            case 61:
                                                return "images/b_bishop.png"
                                            case 62:
                                                return "images/b_horse.png"
                                            case 63:
                                                return "images/b_rock.png"

                                            case 0:
                                                return "images/w_rock.png"
                                            case 1:
                                                return "images/w_horse.png"
                                            case 2:
                                                return "images/w_bishop.png"
                                            case 3:
                                                return "images/w_queen.png"
                                            case 4:
                                                return "images/w_king.png"
                                            case 5:
                                                return "images/w_bishop.png"
                                            case 6:
                                                return "images/w_horse.png"
                                            case 7:
                                                return "images/w_rock.png"
                                            default:
                                                return ""
                                            }
                                        }



                Image{
                    x: cur_x
                    y: cur_y
                    visible: true
                    opacity: 1.0
                    id : unit
                    width: 64
                    height : 64
                    fillMode: Image.PreserveAspectFit
                    source: src

                    property bool dragActive: dragArea.drag.active

                    Drag.active: Drag.Automatic
                    Drag.hotSpot.x: 32
                    Drag.hotSpot.y: 40

                    onDragActiveChanged: {
                        // if the cell is empty, you can not move it
                        // improve the logic later
                        if (src != "" && dragActive) {
                            print("drag started")

                            grabbed_ind = index
                            Drag.start();
                            is_dropped = false;
                        }
                        else {
                            cur_x = x
                            cur_y = y
                            print("drag finished")
                             Layout.row = 2
                             Layout.column  =  3

                            Drag.drop();

                        }
                    }
                    MouseArea{
                        id: dragArea
                        anchors.fill: parent
                        drag.target: unit
                        onPressed:{
                            }


                    }
                }



            }
        }
    }
}
