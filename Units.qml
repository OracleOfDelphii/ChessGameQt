import QtQuick 2.9
import QtQuick.Layouts 1.3
import "graphic.js" as Graphic



Item{
    id: cell_unit
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

