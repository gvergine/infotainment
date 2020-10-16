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

    Clock {
        anchors.fill: parent
    }



}
