import QtQuick 2.9
import QtQuick.Layouts 1.3
import "graphic.js" as Graphic



Item{
    id: cell_unit
    width: 48
    height: 48
    property int  cur_x
    property int  cur_y
    property int  prev_x : unit.x
    property int  prev_y : unit.y
    property int index: 0
    property bool is_white
    property string unit_type : ""
    property  string src

    Component.onCompleted:{
        src = Graphic.unit_src(index)
    }

    Image{
        anchors.centerIn: parent
        fillMode: Image.PreserveAspectFit
        visible: true
        opacity: 1.0
        id : unit
        width: 36
        height : 36
        source: parent.src
    }
}

