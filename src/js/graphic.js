.import Global 1.0 as Global

var boardModel = Global.Global.boardModel

// TO-DO, [color costomization]

//! returns color of a cell specified with index of chess background

// it returns a string showing the move in this format:  <start_cell>.<target_cell>
function move_str(start_index, target_index){
    var from_index = start_index
    var col = String.fromCharCode('a'.charCodeAt(0) + from_index % 8)

    var from =  col + (8 - Math.floor(from_index / 8))

    var to_index = target_index
    col = String.fromCharCode('a'.charCodeAt(0) + to_index % 8)
    var to =  col + (8 - Math.floor(to_index / 8))
    var move = from + '.' + to
    return move
}

function cell_color(index){
    if(index === -1) return ""
    var color1 = "Black"
    var color2 = "Gray"
    if(index === Global.Global.threatened_king){
        return "Orange"
    }
    if(Global.Global.grabbed_ind === index || Global.Global.dropped_ind === index){
        return "purple"
    }

    var row = Math.floor(index / 8);
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
    var move = move_str(Global.Global.grabbed_ind, Global.Global.dropped_ind)

    if(Global.Global.l_board[Global.Global.dropped_ind].cl === "black"){
        if(Global.Global.black_last_5_moves.count === 5) {
            Global.Global.black_last_5_moves.remove(0)
        }
        Global.Global.black_last_5_moves.append(
                    {"mv": move ,
                        "ucolor":
                        Global.Global.l_board[Global.Global.dropped_ind].cl,
                        "src":
                        unit_src(
                            Global.Global.l_board[Global.Global.dropped_ind])
                    })
    }
    else if(Global.Global.l_board[Global.Global.dropped_ind].cl === "white"){
        if(Global.Global.white_last_5_moves.count === 5) {
            Global.Global.white_last_5_moves.remove(0)
        }
        Global.Global.white_last_5_moves.append({"mv": move ,
                                                    "ucolor":
                                                    Global.Global.l_board[Global.Global.dropped_ind].cl,
                                                    "src":
                                                    unit_src(
                                                        Global.Global.l_board[Global.Global.dropped_ind]) })
    }
}


//! returns the icon of a piece by getting information from logical board
//! w_{name}.png for white units, b_{name}.png for black units
//! empty units have no src
function unit_src(unit_at_i){
    if(unit_at_i === undefined) return ""
    var index = unit_at_i.index
    if(Global.Global.l_board[index] === undefined) return ""
    var str1 = Global.Global.l_board[index].cl === "white" ? "w_" : "b_"
    var str2 = Global.Global.l_board[index].unit_type
    if(str2 === "empty") return ""
    return "../../images/" + str1 + str2
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
    var index = Global.Global.bg_grid.indexAt(Global.Global.marea.prev_x,
                                              Global.Global.marea.prev_y)
    if(index >= 0 && index <= 63){
        if(Global.Global.bg_grid.indexAt(prev_x,
                                         Global.Global.marea.prev_y) !==
                Global.Global.grabbed_ind)
            Global.Global.bg_grid.itemAt(prev_x, Global.Global.marea.prev_y).cl = cell_color(index)
        if(Global.Global.bg_grid.indexAt(Global.Global.marea.mouseX, Global.Global.marea.mouseY) !== Global.Global.grabbed_ind)
            Global.Global.bg_grid.itemAt(Global.Global.marea.mouseX, Global.Global.marea.mouseY).cl = "Blue"
        // bug on android since there is no hover
    }
    Global.Global.marea.prev_x = Global.Global.marea.mouseX
    Global.Global.marea.prev_y = Global.Global.marea.mouseY
}





