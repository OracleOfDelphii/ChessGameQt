/*
each unit is a logical chess unit, which
later a graphical instance will be built from it.
*/

// add has_vertical, has_horizontal, has diagonal move to Unit class


class Unit {
    // utype -> unit type
    // color -> {black,white}
    // color costumization doesnt affect this class
    constructor(color, utype, index) {
        this.color = color
        this.unit_type = utype
        this.index = index
    }
    get utype(){
        return this.unit_type
    }
    get cl(){
        return this.color
    }
}

function is_valid_vertical(start_index, target_index){

    var start_unit = l_board[start_index]
    var tar_unit = l_board[target_index]
    var up_unit= l_board[Math.max(start_index, target_index)]
    var lp_unit = l_board[Math.min(start_index, target_index)]
    var king = start_unit.utype === "king"
    var soldier = start_unit.utype === "soldier"
    var dist = Math.abs(start_index - target_index)

    if(king){
        if(dist > 9 || dist < 7) return false
    }
    if(soldier){
        if(turn == 0){
            if(dist > 16) return false
            if(dist === 16) return true
        }
        else{
            if(dist > 8) return false
        }
    }
    var found = false
    for(var i = Math.max(start_index, target_index) - 8; i >= Math.min(start_index, target_index); i-=8){
        // fix later
        if(up_unit.utype !== "empty"){
            if(l_board[i].utype !== "empty" && l_board[i] !== lp_unit){
                return false;
            }
        }
        else{
            if(l_board[i].utype !== "empty" && l_board[i] !== lp_unit){

                return false;
            }
        }

        if(i ===  Math.min(start_index, target_index)) found = true
    }

    if(!found) return false
    if(tar_unit.color === start_unit.color){
        return false;
    }
    if(soldier && tar_unit.utype !== "empty"){
        return false;
    }

    return true;
}



function is_valid_diagonal(start_index, target_index){
    var start_unit = l_board[start_index]
    var tar_unit = l_board[target_index]
    var up_unit= l_board[Math.max(start_index, target_index)]
    var lp_unit = l_board[Math.min(start_index, target_index)]
    var king = start_unit.utype === "king"
    var soldier = start_unit.utype === "soldier"
    if(king || soldier){
        var dist = Math.abs(start_index - target_index)
        if(dist > 9 || dist < 7) return false
    }

    if(soldier){

        if(tar_unit.utype === "empty"){
            return false
        }
        if(start_unit.cl === starter){

            if(start_unit !== up_unit){
                return false
            }
            var c1 = (target_index === start_index - 9)
            var c2 = (target_index === start_index - 7)
            if(!(c1 || c2)){
                return false
            }
        }

        if(start_unit.cl !== starter){
            if(start_unit === up_unit){
                return false
            }
            else{
                c1 = (target_index === start_index + 9)
                c2 = (target_index === start_index + 7)
                if(!(c1 || c2)){
                    return false
                }
            }
        }
    }
    else{
        var found = false
        if(target_index % 8 > start_index % 8){
            for(var i = Math.max(start_index, target_index) - 9; i >= Math.min(start_index, target_index); i -=9){
                if(l_board[i].utype !== "empty"){
                    return false;
                }
                if(i ===  Math.min(start_index, target_index)) found = true
            }
        }
        else if(target_index % 8 < start_index % 8){
            for(i = Math.max(start_index, target_index) - 7; i >= Math.min(start_index, target_index); i -=7){

                // fix later
                if(up_unit.utype !== "empty"){
                    if(l_board[i].utype !== "empty" && l_board[i] !== up_unit){
                        return false;
                    }
                }
                else{
                    if(l_board[i].utype !== "empty" && l_board[i] !== lp_unit){
                        return false;
                    }
                }

                if(i ===  Math.min(start_index, target_index)) found = true
            }
        }


        if(!found) return false

    }
    if(tar_unit.color === start_unit.color){
        return false;
    }
    return true;
}


function create_table(){
    var board = []
    for(var i = 0; i <= 63; i++){
        let un = new Unit()
        var index = i;
        if(index === 20){
            un = new Unit("white", "soldier", index)
            board.push(un)
        }

        if((index > 7 && index <= 15 && index !==8)) {
            un = new Unit("black", "soldier", index)
            board.push(un)
        }
        else if((index >= 48 && index < 56)) {
            un = new Unit("white", "soldier", index)
            board.push(un)
        }
        else{
            switch(index){
            case 56:
                un = new Unit("white", "rock", index)
                board.push(un)
                break;
            case 57:
                un = new Unit("white", "horse", index)
                board.push(un)
                break;
            case 58:
                un = new Unit("white", "bishop", index)
                board.push(un)
                break;
            case 59:
                un = new Unit("white", "queen", index)
                board.push(un)
                break;
            case 60:
                un = new Unit("white", "king", index)
                board.push(un)
                break;
            case 61:
                un = new Unit("white", "bishop", index)
                board.push(un)
                break;
            case 62:
                un = new Unit("white", "horse", index)
                board.push(un)
                break;
            case 63:
                un = new Unit("white", "rock", index)
                board.push(un)
                break;

            case 0:
                un = new Unit("black", "rock", index)
                board.push(un)
                break;
            case 1:
                un = new Unit("black", "horse", index)
                board.push(un)
                break;
            case 2:
                un = new Unit("black", "bishop", index)
                board.push(un)
                break;
            case 3:
                un = new Unit("black", "queen", index)
                board.push(un)
                break;
            case 4:
                un = new Unit("black", "king", index)
                board.push(un)
                break;
            case 5:
                un = new Unit("black", "bishop", index)
                board.push(un)
                break;
            case 6:
                un = new Unit("black", "horse", index)
                board.push(un)
                break;
            case 7:
                un = new Unit("black", "rock", index)
                board.push(un)
                break;
            default:
                un = new Unit("", "empty", index)
                board.push(un)
            }
        }
    }
    return board;
}

// checks if game reached check state
// uindex is attacker_unit
// tc_index is target cell index
function is_check(start, target){
    return false
}


// checks if game is finished
function is_mate(start,target){
    return false;
}

function get_unit_type(index){
    return main.l_board[index].type
}

function is_valid_mv(start_index, target_index){
    if(is_mate(start_index, target_index)) return false
    if(is_check(start_index, target_index)) return false
    var start_unit = l_board[start_index]
    var tar_unit = l_board[target_index]

    switch(start_unit.utype){
    case "soldier":
        var cd1 = is_valid_vertical(start_index, target_index)
        var cd2 = is_valid_diagonal(start_index, target_index)
        if(cd1 || cd2){
            return true
        }

        return false;

    case "bishop":
        return is_valid_diagonal(start_index, target_index)

    case "rock":
        return is_valid_vertical(start_index, target_index)
    }

}
