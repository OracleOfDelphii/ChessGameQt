.import "logic.js" as Logic
// TO-DO, [color costomization]

//! returns color of a cell specified with index of chess background
function cell_color(index) {
    if(index === -1) return ""
    var color1 = "Black"
    var color2 = "Gray"
    if(index === threatened_king){
        return "Orange"
    }
    if(grabbed_ind === index || dropped_ind === index){
        return "purple"
    }


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

//! adds last move to last 5 move lists
function add_last_move(){
    var move = Logic.move_str(grabbed_ind, dropped_ind)

    if(l_board[dropped_ind].ucolor === "black"){
        if(black_last_5_moves.count === 5) {
            black_last_5_moves.remove(0)
        }
        black_last_5_moves.append({"mv": move , "ucolor":
                                      l_board[dropped_ind].ucolor, "src":
                                      unit_src(l_board[dropped_ind].index) })
    }
    else if(l_board[dropped_ind].ucolor === "white"){
        if(white_last_5_moves.count === 5) {
            white_last_5_moves.remove(0)
        }
        white_last_5_moves.append({"mv": move ,
                                      "ucolor": l_board[dropped_ind].ucolor,
                                      "src": unit_src(l_board[dropped_ind].index) })
    }
}


//! returns the icon for a piece by getting information from logical board
//! w_{name}.png for white units, b_{name}.png for black units
//! empty units have no src
function unit_src(index){
    var str1 = l_board[index].ucolor === "white" ? "w_" : "b_"
    var str2 = l_board[index].unit_type
    if(str2 === "empty") return ""
    return "images/" + str1 + str2
}

function move(start_index, target_index){
    if( start_index < target_index){
        boardModel.move(start_index, target_index, 1)

        boardModel.move(target_index - 1, start_index, 1)
    }
    else{
        boardModel.move(target_index, start_index, 1)
        boardModel.move(start_index - 1, target_index, 1)
    }
}


function hover_cell(){
    var index = bg_grid.indexAt(marea.prev_x, marea.prev_y)
    if(index >= 0 && index <= 63){
        if(bg_grid.indexAt(prev_x, marea.prev_y) !== grabbed_ind)
            bg_grid.itemAt(prev_x, marea.prev_y).cl = cell_color(index)
        if(bg_grid.indexAt(marea.mouseX, marea.mouseY) !== grabbed_ind)
            bg_grid.itemAt(marea.mouseX, marea.mouseY).cl = "Blue"
        // bug on android since there is no hover
    }
    marea.prev_x = marea.mouseX
    marea.prev_y = marea.mouseY
}





