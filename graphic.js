.import "logic.js" as Logic

var index = 0;

// returns color of a cell specified with index of chess background
// TO-DO, [color costomization]
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

function set_index(){
    if(index <= 63){
        return index++;

    }
}

// returns the true icon for a piece by getting information from logical board
// w_{name} for white units, b_{name} for black units
function unit_src(index){
    var str1 = l_board[index][0] === true ? "b_" : "w_"
    var str2 = l_board[index][1]
    if(str2 === "") return ""
    return "images/" + str1 + str2
}




