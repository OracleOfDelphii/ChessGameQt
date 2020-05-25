// TO-DO write unit tests

//! A class containing information about each player
class Player {
    constructor(name, color){
        this.name = name
        this.ucolor = color
        this.check = false
        this.move_history = []
        this.win_cnt = 0
        this.lose_cnt = 0
        this.draw_cnt = 0
    }
    // get number of movements this player made
    get move_num(){
        return this.move_history.length
    }
    // adds a move to player move history
    add_move(move){
        this.move_history.push(move)
    }

    print_history(){
      for(var i = 0; i < this.move_history.length; i++){
            console.log(this.move_history[i])
        }
    }

}

function try_move(start_index, target_index){
    var dropped_unit = l_board[target_index]
    var grabbed_unit = l_board[start_index]
    var cl = players[player_turn].ucolor
    var op_cl = cl === "white" ? "black" : "white"

    if(grabbed_unit.ucolor === players[player_turn].ucolor){
        var valid_move = Logic.is_valid_mv(start_index, target_index, l_board)
        var threated = Logic.check(start_index, target_index, l_board, cl)
        if(valid_move && (threated === -1)){
            threatened_king = -1
            if(start_index === b_king_pos){
                b_king_pos = target_index
            }

            if(start_index === w_king_pos){
                w_king_pos = target_index
            }

            var threatened = check(start_index, target_index, l_board, op_cl)


            if(threatened !== -1){

                threatened_king = threatened
            }

            if(grabbed_unit.ucolor === "white"){
                white_unit_indices[l_board[start_index].id] = target_index
                white_unit_indices[l_board[target_index].id] = -1
            }
            if(grabbed_unit.ucolor === "black"){
                black_unit_indices[l_board[start_index].id] = target_index
                black_unit_indices[l_board[target_index].id] = -1
            }


            if(player_turn == 0){
                player_turn = 1
            }
            else{
                player_turn = 0
            }

            // move in logical board
            l_board[start_index].index = target_index
            l_board[target_index] = l_board[start_index]
            l_board[start_index] = empty_unit(-1)
            players[player_turn].add_move(move_str(start_index, target_index))


            return true
        }

    }
    return false
}

function move_str(start_index, target_index){
    var from_index = start_index
    var col = String.fromCharCode('a'.charCodeAt(0) + from_index % 8)
    var from =  col + (8 - Math.floor(from_index / 8))

    var to_index = target_index
    col = String.fromCharCode('a'.charCodeAt(0) + to_index % 8)
    var to =  col + (8 - Math.floor(to_index / 8))
    var move = from + '->' + to
    return move
}

class Game{
    constructor(type = "normal", board, turn, player1, player2) {
        this.type = "normal"
        this.board = []
        this.turn = 0
        this.player1 = player1
        this.player2 = player2
    }

    load(Path){

    }
    save(Path){

    }
    reset(){

    }
    newPlayer(){

    }
    newGame(type){

    }
}



// for test, will be changed later
function create_player(){
    var players = []
    var p1 = new Player("Ali", "white")
    var p2 = new Player("Reza", "black")
    players.push(p1)
    players.push(p2)
    return players
}

// TO-DO add has_vertical, has_horizontal, has diagonal move to Unit class
class Unit {
    // utype -> unit type
    // color -> {black, white}
    // color costumization doesnt affect this class
    constructor(cl, utype, index = -1, id) {
        this.cl = cl
        this.unit_type = utype
        this.index = index
        this.id = id
    }
    get utype(){
        return this.unit_type
    }
    get ucolor(){
        return this.cl
    }
}

//! TO-DO
function is_mate(){

}

//! returns an empty unit to fill the cells with no chess piece

function empty_unit(index){
    return new Unit("", "empty", index)
}

//! checks if horse can jump to target or not
function is_valid_jump(start_index, target_index, board){
    var start_unit = board[start_index]
    var tar_unit = board[target_index]
    // conditions to check
    var cd1, cd2, cd3, cd4, cd5, cd6, cd7, cd8
    if(tar_unit.ucolor === start_unit.ucolor){
        return false;
    }
    // atmost, there are 8 possible positions horse can jump into.
    cd1 = (start_index + 15) === target_index
    cd2 = (start_index - 15) === target_index
    cd3 = (start_index + 17) === target_index
    cd4 = (start_index - 17) === target_index
    cd5 = (start_index + 6) === target_index
    cd6 = (start_index - 6) === target_index
    cd7 = (start_index + 10) === target_index
    cd8 = (start_index - 10) === target_index

    if(cd1 || cd2 || cd3 || cd4) return true;
    if(cd5 || cd6 || cd7 || cd8) return true;
    return false;
}

// this function always starts from upper position on the board to the lower position and
// checks if they can meet together with a vertical move of starter
function is_valid_vertical(start_index, target_index, board){

    var start_unit = board[start_index]
    var tar_unit = board[target_index]
    var up_unit= board[Math.max(start_index, target_index)]
    var lp_unit = board[Math.min(start_index, target_index)]
    var up_index = Math.max(start_index, target_index)
    var lp_index = Math.min(start_index, target_index)
    var king = start_unit.utype === "king"
    var soldier = start_unit.utype === "soldier"
    var dist = Math.abs(start_index - target_index)

    if(king){
        if(dist !== 8) return false
    }

    // bug
    if(soldier){
        var cl = start_unit.ucolor
        if(tar_unit.utype !== "empty"){
            return false;
        }
        var b_soldier_init_ind = start_index > 7 && start_index <= 15;
        var w_soldier_init_ind = start_index >= 48 && start_index < 56;
        var is_first_move = ((cl === "white") && w_soldier_init_ind)
                || ((cl === "black") && b_soldier_init_ind)
        if(is_first_move){
            if(dist > 16) return false
            if(dist === 16) return true
        }
        else{
            if(dist > 8) return false
            if(cl === "white"){
                if(target_index > start_index) return false
            }
            if(cl === "black"){
                if(target_index < start_index) return false
            }
        }
    }
    var found = false

    for(var i = Math.max(start_index, target_index) - 8; i >= Math.min(start_index, target_index); i-=8){
        if(board[i].utype !== "empty" && board[i] !== lp_unit){

            return false;
        }

        if(i ===  Math.min(start_index, target_index)) found = true
    }

    if(!found) return false

    if(tar_unit.ucolor === start_unit.ucolor){
        return false;
    }


    return true;
}


//! this function always starts from upper position on the board to the lower position and
// checks if they can meet together with a horizontal move of starter
function is_valid_horizontal(start_index, target_index, board){

    var start_unit = board[start_index]
    var tar_unit = board[target_index]
    var up_unit= board[Math.max(start_index, target_index)]
    var lp_unit = board[Math.min(start_index, target_index)]
    var up_pos = Math.max(start_index, target_index)
    var lp_pos = Math.min(start_index, target_index)
    //
    var king = start_unit.utype === "king"
    var dist = Math.abs(start_index - target_index)

    if(king){
        if(dist > 1) return false
    }

    if(Math.floor((up_pos) / 8) !== Math.floor((lp_pos) / 8)){

        return false
    }

    var found = false
    for(var i = up_pos - 1; i >= lp_pos; i--){

        if(board[i].utype !== "empty" && board[i] !== lp_unit){
            return false;
        }

        if(i === Math.min(start_index, target_index)) found = true
    }

    if(!found) return false
    if(tar_unit.ucolor === start_unit.ucolor){
        return false;
    }

    return true;
}

//! this function always starts from upper position on the board to the lower position and
// checks if they can meet together with a diagonal move of starter
function is_valid_diagonal(start_index, target_index, board){
    var start_unit = board[start_index]
    var tar_unit = board[target_index]
    var up_unit= board[Math.max(start_index, target_index)]
    var lp_unit = board[Math.min(start_index, target_index)]
    var up_pos = Math.max(start_index, target_index)
    var lp_pos = Math.min(start_index, target_index)
    var king = start_unit.utype === "king"
    var soldier = start_unit.utype === "soldier"
    if(king || soldier){
        var dist = Math.abs(start_index - target_index)
        if(dist !== 9 &&  dist !== 7) return false
    }

    if(soldier){
        if(tar_unit.utype === "empty"){
            return false
        }
        if(start_unit.ucolor === starter){
            if(start_unit !== up_unit){
                return false
            }

        }
    }

    var found = false
    // checks for diagonal move in north-west direction
    if(up_pos % 8 > lp_pos % 8 && (up_pos % 8 !== 0)){
        for(var i = up_pos - 9; i >= lp_pos; i -=9){
            if(board[i].utype !== "empty" && board[i] !== lp_unit){

                return false;
            }
            if(i ===  Math.min(start_index, target_index)) found = true
        }
    }

    // checks for diagonal move in north-east direction
    else if(up_pos % 8 < lp_pos % 8 && (up_pos + 1) % 8 !== 0){
        for(i = up_pos - 7; i >= lp_pos; i -= 7){
            if(board[i].utype !== "empty" && board[i] !== lp_unit){
                return false;
            }

            if(i === lp_pos) found = true
        }
    }
    if(!found) return false

    if(tar_unit.ucolor === start_unit.ucolor){

        return false;
    }

    return true;
}

function get_unit_index(board, w_unit_indices, b_unit_indices, id){
    var utype = board[index].utype
    if(utype === "black"){
        return b_unit_indices[id]
    }
    else if(utype === "white"){
        return w_unit_indices[id]
    }
    else{
        return -1
    }

}

function create_table(){
    var board = []
    var cnt = 0
    for(var i = 0; i <= 63; i++){
        let un = new Unit()
        var index = i;

        if((index > 7 && index <= 15 )) {
            un = new Unit("black", "soldier", i, cnt)
            board.push(un)
            black_unit_indices[cnt] = i
            cnt++;
        }
        else if(index >= 16 && index < 48){
            cnt = 0
            un = new Unit("", "empty", index, -1)
            board.push(un)
        }
        else if((index >= 48 && index < 56)) {
            un = new Unit("white", "soldier", i, cnt)
            board.push(un)
            cnt++;
            white_unit_indices[cnt] = i
        }
        else{
            switch(index){
            case 56:
                un = new Unit("white", "rock", i, cnt)
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;
            case 57:
                un = new Unit("white", "horse", i, cnt)
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;
            case 58:
                un = new Unit("white", "bishop", i, cnt)
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;
            case 59:
                un = new Unit("white", "king", i, cnt)
                w_king_pos = index
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;
            case 60:
                un = new Unit("white", "queen", i, cnt)

                white_unit_indices[cnt] = i
                board.push(un)
                cnt++; break;
            case 61:
                un = new Unit("white", "bishop", i, cnt)
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;
            case 62:
                un = new Unit("white", "horse", i, cnt)
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;
            case 63:
                un = new Unit("white", "rock", i, cnt)
                board.push(un)
                white_unit_indices[cnt] = i
                cnt++; break;


            case 0:
                un = new Unit("black", "rock", i, cnt)
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;
            case 1:
                un = new Unit("black", "horse", i, cnt)
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;
            case 2:
                un = new Unit("black", "bishop", i, cnt)
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;
            case 3:
                un = new Unit("black", "king", i, cnt)
                b_king_pos = index
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;
            case 4:
                un = new Unit("black", "queen", i, cnt)

                black_unit_indices[cnt] = i
                board.push(un)
                cnt++; break;
            case 5:
                un = new Unit("black", "bishop", i, cnt)
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;
            case 6:
                un = new Unit("black", "horse", i, cnt)
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;
            case 7:
                un = new Unit("black", "rock", i, cnt)
                board.push(un)
                black_unit_indices[cnt] = i
                cnt++; break;

            }
        }
    }
    return board;
}

//! checks if the player is check
// returns position of threatened king, if no one, returns -1
// It creates a virtual board, makes a movement and checks if
// in that scenario the king is threatened or not.
function check(start_index, target_index, board, color){
    var future_board = Object.assign([], board);
    var future_white_unit_indices = Object.assign([],  white_unit_indices)
    var future_black_unit_indices = Object.assign([],  black_unit_indices)
    var tmp_turn = player_turn
    var white_king_pos = w_king_pos
    var black_king_pos = b_king_pos

    if(start_index === w_king_pos){
        white_king_pos = target_index
    }
    if(start_index === b_king_pos){
        black_king_pos = target_index
    }

    if(color === "black")
        if(future_board[start_index].ucolor === "white"){
            if(future_board[start_index].id !== -1)
                future_white_unit_indices[future_board[start_index].id] =  target_index
            if(future_board[target_index].id !== -1)
                future_white_unit_indices[future_board[target_index].id] =  -1
        }

    if(color === "white")
        if(future_board[start_index].ucolor === "black"){
            if(future_board[start_index].id !== -1)
                future_black_unit_indices[future_board[start_index].id] =  target_index
            if(future_board[target_index].id !== -1)
                future_black_unit_indices[future_board[target_index].id] =  -1
        }

    future_board[start_index].index = future_board[target_index].index
    future_board[target_index]  = future_board[start_index]
    future_board[start_index] =  empty_unit(-1)

    var threatened = -1

    if(color === "white")
        future_black_unit_indices.forEach(function(uindex) {

            if(is_valid_mv(uindex, white_king_pos, future_board)){
                console.log("attacker:" + uindex + " " + "king position" + white_king_pos)
                threatened = w_king_pos

            }
        })

    if(color === "black")
        future_white_unit_indices.forEach(function(uindex) {

            if(is_valid_mv(uindex, black_king_pos, future_board)){
                console.log("attacker:" + uindex + " " + "king position" + black_king_pos)
                threatened = b_king_pos
            }
        })

    player_turn = tmp_turn
    return threatened

}

function get_unit_type(index){
    return main.l_board[index].type
}

//! start_index, target_index are positions in board
function is_valid_mv(start_index, target_index, board){

    var start_unit = board[start_index]
    var tar_unit = board[target_index]
    var cl = player_turn == 0 ? "white" : "black"
    var op_king = ""

    if(start_unit === undefined){
        return false
    }
    //! conditions to check different kind of movements
    var cd1, cd2, cd3, cd4
    switch(start_unit.utype){

    case "soldier":
        cd1 = is_valid_vertical(start_index, target_index, board)
        cd2 = is_valid_diagonal(start_index, target_index, board)
        return (cd1 || cd2)
    case "bishop":

        return is_valid_diagonal(start_index, target_index, board)

    case "rock":
        cd1 = is_valid_vertical(start_index, target_index, board)
        cd2 = is_valid_horizontal(start_index, target_index, board)
        return (cd1 || cd2)

    case "king":
        cd1 = is_valid_vertical(start_index, target_index, board)
        cd2 = is_valid_horizontal(start_index, target_index, board)
        cd3 = is_valid_diagonal(start_index, target_index, board)

        return cd1 || cd2 || cd3

    case "queen":
        cd1 = is_valid_vertical(start_index, target_index, board)
        cd2 = is_valid_horizontal(start_index, target_index, board)
        cd3 = is_valid_diagonal(start_index, target_index, board)

        return cd1 || cd2 || cd3

    case "horse":
        return is_valid_jump(start_index, target_index, board)
    }
}
