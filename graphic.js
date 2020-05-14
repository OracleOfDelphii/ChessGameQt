function cell_color(index) {
var row = Math.floor(index / 8) ;
var col = index - (row - 1) * 8;
    if(row % 2 == 0){
        if(col % 2 == 0) return "Black"
        else return "Gray"
    }
    else{
        if(col % 2 == 0) return "Gray"
        else return "Black"
    }
}

