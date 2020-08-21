import QtQuick 2.12
import QtQuick.Layouts 1.3
import "graphic.js" as Graphic


// Chess piece
Item{
    id: chess_piece
    width: 48
    height: 48

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
        width: 36
        height: 36
        source: src
    }
}

