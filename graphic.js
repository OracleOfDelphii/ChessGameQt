.import "logic.js" as Logic

var index = 0;

// returns color of a cell specified with index of chess background
// TO-DO, [color costomization]
// TO-Do, statistics

function cell_color(index) {
    var color1 = "Black"
    var color2 = "Gray"
    var row = Math.floor(index / 8) ;
    var col = index - (row - 1) * 8;
    if(row % 2 == 0){
        if(col % 2 == 0) return color1
        else return color2
    }
    else{
        if(col % 2 == 0) return color2
        else return color1
    }
}

// last 4 moves
function add_last5_move(){
    if(last_5_moves.count === 5) {
        last_5_moves.remove(0)
    }
    var index = grabbed_ind
    var col = String.fromCharCode('a'.charCodeAt(0) + index % 8)
    var from =  col + (8 - Math.floor(index / 8))

    index = dropped_ind
    col = String.fromCharCode('a'.charCodeAt(0) + index % 8)
    var to =  col + (8 - Math.floor(index / 8))
    var move =   from + '->' + to
    last_5_moves.append({"mv" : move , "ucolor": l_board[dropped_ind].ucolor, "src": unit_src(grabbed_ind) })
}


// returns the true icon for a piece by getting information from logical board
// w_{name} for white units, b_{name} for black units
function unit_src(index){
    var str1 = l_board[index].ucolor === "white" ? "w_" : "b_"
    var str2 = l_board[index].unit_type
    if(str2 === "empty") return ""
    return "images/" + str1 + str2
}

function update_state(){
    /*
   if mode == 0 : player 1 is still choosing
   if mode == 1 : player 2 is going to choose
   if mode == 2 : no one is choosing, no action this time
*/

    /*
    blue is hover( incomplete for android since there is no hover)
    purple is player 1


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
      */
}

function hover_cell(){
    var index = bg_grid.indexAt(marea.prev_x, marea.prev_y)
    if(index >= 0 && index <= 63){
        if(bg_grid.indexAt(prev_x, marea.prev_y) !== grabbed_ind)
            bg_grid.itemAt(prev_x, marea.prev_y).cl = Graphic.cell_color(index)
        if(bg_grid.indexAt(marea.mouseX, marea.mouseY) !== grabbed_ind)
            bg_grid.itemAt(marea.mouseX, marea.mouseY).cl = "Blue"
        // bug on android since there is no hover
    }
    marea.prev_x = marea.mouseX
    marea.prev_y = marea.mouseY
}





