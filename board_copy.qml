import QtQuick 2.0
import QtQuick.Window 2.3
Window {
    id:main
    visible: true
    width: 800; height: 600

    DropArea {
        width: 100; height: 100; anchors.centerIn: parent

        Rectangle {
            anchors.fill: parent
            color: parent.containsDrag ? "red" : "green"
        }

        onEntered: print("entered");
        onExited: print("exited");
        onDropped: print("dropped");
    }

    Rectangle {
        x: 15; y: 15; width: 30; height: 30; color: "blue"

        // I've added this property for simplicity's sake.
        property bool dragActive: dragArea.drag.active

        // This can be used to get event info for drag starts and
        // stops instead of onDragStarted/onDragFinished, since
        // those will neer be called if we don't use Drag.active
        onDragActiveChanged: {
            if (dragActive) {
                print("drag started")
                Drag.start();
            } else {
                print("drag finished")
                Drag.drop();
            }
        }

        Drag.dragType: Drag.Automatic

        // These are now handled above.
        //Drag.onDragStarted: print("drag started");
        //Drag.onDragFinished: print("drag finished");

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
        }
    }
}
