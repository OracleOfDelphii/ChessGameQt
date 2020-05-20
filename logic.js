/*
  this function returns logical board
  In ui, the background and units are seperated,
  but with logic this seperation is unnecessary
*/

class Unit {
    constructor(color, utype, index) {
        this.color = color
        this.unit_type = utype
        this.index = index
    }
    is_white(){
        return this.color === "white"
    }
    get utype(){
        return unit_type
    }
    is_valid_mv(target){
        switch(this.unit_type){
            case "horse":
            if(this.is_white()){
                if(target === this.index + 8)
                return true;
            }
            else{
                if(target === this.index  - 8)
                return true;
            }

            return false;
        }
    }
}


function create_table(){
    var board = []
    for(var i = 0; i <= 63; i++){
        let un = new Unit()
        var index = i;
        if((index > 7 && index <= 15)) {
            un = new Unit("white", "soldier", index)
            board.push(un)
        }
        else if((index >= 48 && index < 56)) {
            un = new Unit("black", "soldier", index)
            board.push(un)
        }
        else{
            switch(index){
            case 56:
                un = new Unit("black", "rock", index)
                board.push(un)
                break;
            case 57:
                un = new Unit("black", "horse", index)
                board.push(un)
                break;
            case 58:
                un = new Unit("black", "bishop", index)
                board.push(un)
                break;
            case 59:
                un = new Unit("black", "queen", index)
                board.push(un)
                break;
            case 60:
                un = new Unit("black", "king", index)
                board.push(un)
                break;
            case 61:
                un = new Unit("black", "bishop", index)
                board.push(un)
                break;
            case 62:
                un = new Unit("black", "horse", index)
                board.push(un)
                break;
            case 63:
                un = new Unit("black", "rock", index)
                board.push(un)
                break;

            case 0:
                un = new Unit("white", "rock", index)
                board.push(un)
                break;
            case 1:
                un = new Unit("white", "horse", index)
                board.push(un)
                break;
            case 2:
                un = new Unit("white", "bishop", index)
                board.push(un)
                break;
            case 3:
                un = new Unit("white", "queen", index)
                board.push(un)
                break;
            case 4:
                un = new Unit("white", "king", index)
                board.push(un)
                break;
            case 5:
                un = new Unit("white", "bishop", index)
                board.push(un)
                break;
            case 6:
                un = new Unit("white", "horse", index)
                board.push(un)
                break;
            case 7:
                un = new Unit("white", "rock", index)
                board.push(un)
                break;
            default:
                un = new Unit("black", "", index)
                board.push(un)
            }
        }
    }
    return board;
}

// checks if game reached check state
// uindex is attacker_unit
// tc_index is target cell index
function is_check(uindex, tc_index){
    if(!is_valid_mv(tc_index)) return "black"
    switch (get_unit_type(uindex)) {
    case "soldier":
    case "bishop":
    case "":
    }
}


// checks if game is finished
function is_mate(){

}

function get_unit_type(index){
    return main.l_board[index].type
}

// it returns a boolean value for player movements, "white" if it's a valid move, "black" otherwise.
function is_valid_mv(index){
    return "white";
}
