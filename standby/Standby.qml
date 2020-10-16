import QtQuick 2.0

import "."

Item
{
    id: root
    signal resumeEvent()



    Rectangle {
        anchors.fill: parent
        color: "#000000"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.resumeEvent()
            }
        }
    }

    Flipable {
        id: flipable

        anchors.fill: parent


        property bool flipped: true

        front:
            Clock {
                anchors.fill: parent
                onMinutesChanged: flipable.flipped = !flipable.flipped
            }
        back:
            Clock {
                anchors.fill: parent
            }

        transform: Rotation {
            id: rotation
            origin.x: flipable.width/2
            origin.y: flipable.height/2
            axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
            angle: 0    // the default angle
        }

        states: State {
            name: "back"
            PropertyChanges { target: rotation; angle: 180 }
            when: flipable.flipped
        }

        transitions: Transition {
            NumberAnimation { target: rotation; property: "angle"; duration: 2000 }
        }


    }




}
