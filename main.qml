import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.VirtualKeyboard 2.4

Window {
    id: window
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")
    color: "#000000"

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

    GridView {
        id: gridView
        x: 80
        y: 80
        width: 1024 - 80
        height: 600 - 80




        model: ListModel {
            ListElement {
                name: "Maps"
                icon: "assets/mapsicon.png"
            }
            ListElement {
                name: "Video"
                icon: "assets/videoplayericon.png"
            }
            ListElement {
                name: "Settings"
                icon: "assets/settingsicon.png"
            }
            ListElement {
                name: "Light mode"
                icon: "assets/daynight.png"
            }
            ListElement {
                name: "Turn off"
                icon: "assets/officon.png"
            }

        }
        delegate: Item {
            x: 5
            height: 150

            Column {

                Image {
                    width: 128
                    height: 128
                    source: icon
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: name
                    color: "#ffffff"
                    font.pointSize: 16
                    font.weight: Font.Thin
                    font.family: "Helvetica"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                spacing: 10
            }
        }
        cellWidth: 236
        cellHeight: 256

    }
}
