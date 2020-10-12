import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4
import QtQuick.Layouts 1.12

import "home" as Home
import "maps" as Maps
import "videoplayer" as VideoPlayer

Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Infotainment")
    color: "#000000"

    StackLayout {
        id: layout
        anchors.fill: parent
        currentIndex: 0

        Home.Home {
            onAppSelected: layout.currentIndex = appId

        }

        Maps.Maps {
            onHomeButton: layout.currentIndex = 0

        }

        VideoPlayer.VideoPlayer {
            onHomeButton: layout.currentIndex = 0

        }


    }


    // virtual keyboard

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }



}
