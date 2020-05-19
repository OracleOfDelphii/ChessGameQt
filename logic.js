/*
  this function returns logical board
  In ui, the background and units are seperated,
  but with logic this seperation is unnecessary
*/
function create_table(){

    var board = []
    for(var i = 0; i <= 63; i++){
        board.push([false,""])
        var index = i;
        if((index > 7 && index <= 15)) {
            board[i][1] = "soldier"
            board[i][0] = true
        }
        else if((index >= 48 && index < 56)) {
            board[i][1] = "soldier"
            board[i][0] = false
        }
        else{
            switch(index){
            case 56:
                board[i][1] = "rock"
                board[i][0] = false
                break;
            case 57:
                board[i][0] = false
                board[i][1] = "horse"
                break;
            case 58:
                board[i][0] = false
                board[i][1] = "bishop"
                break;
            case 59:
                board[i][0] = false
                board[i][1] = "queen"
                break;
            case 60:
                board[i][0] = false
                board[i][1] = "king"
                break;
            case 61:
                board[i][0] = false
                board[i][1] = "bishop"
                break;
            case 62:
                board[i][0] = false
                board[i][1] = "horse"
                break;
            case 63:
                board[i][0] = false
                board[i][1] = "rock"
                break;

            case 0:
                board[i][0] = true
                board[i][1] = "rock"
                break;
            case 1:
                board[i][0] = true
                board[i][1] = "horse"
                break;
            case 2:
                board[i][0] = true
                board[i][1] = "bishop"
                break;
            case 3:
                board[i][0] = true
                board[i][1] = "queen"
                break;
            case 4:
                board[i][0] = true
                board[i][1] = "king"
                break;
            case 5:
                board[i][0] = true
                board[i][1] = "bishop"
                break;
            case 6:
                board[i][0] = true
                board[i][1] = "horse"
                break;
            case 7:
                board[i][0] = true
                board[i][1] = "rock"
                break;
            default:
                board[i][0] = false
                board[i][1] = ""
                break;
            }
        }
    }
    return board;
}

// checks if game reached check state
function is_check(){

}

// checks if game is finished
function is_mate(){

}
// it returns a boolean value for player movements, true if it's a valid move, false otherwise.
function is_valid_mv(unit_type){
    switch(board[i][1]){
    case "bishop":
break;

    }
}
