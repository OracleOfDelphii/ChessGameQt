import QtQuick 2.12
import QtQuick.Layouts 1.3
import "../js/graphic.js" as Graphic


// Chess piece
Item{
    id: chess_piece
    width:  Math.min(main.width/8,48)
    height:  Math.min(main.width/8,48)

    property int index: 0
    property bool is_white: false
    property string unit_type: ""
    property  string src: ""

    Image{
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        visible: true
        opacity: 1.0
        id: unit
        width: parent.width - 8

        height: parent.height - 4
        source: src
    }
}

