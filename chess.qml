import QtQuick 2.6
import QtQuick.Window 2.2
import "graphic.js" as Graphic
Window {
    id : main
    visible: true
    width: 8 * 64 + 4
    height: 8 * 64 + 4

    title: qsTr("Hello World")
    /*
    Column{
        x : 2
        y : 2
        Repeater{
            model : 4
            Column{
                Row{
                    Repeater{
                        model : 4
                        Row{
                            Rectangle {
                                width : 64
                                height : 64
                                color : "gray"
                            }
                            Rectangle {
                                width : 64
                                height : 64
                                color : "black"
                            }
                        }
                    }
                }
                Row{
                    Repeater{
                        model : 4
                        Row{
                            Rectangle {
                                width : 64
                                height : 64
                                color : "black"
                            }
                            Rectangle {
                                width : 64
                                height : 64
                                color : "gray"
                            }
                        }
                    }
                }
            }
        }
    }
    */
    Grid{
        x : 2
        y : 2
        rows : 8
        columns: 8
        Repeater{
            model : 64
            Rectangle{
                width : 64
                height : 64
                color : Graphic.cell_color(index)
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        parent.color = "Blue"
                    }
                }
            }

        }
    }

}
