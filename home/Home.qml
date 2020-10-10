import QtQuick 2.12

Item {

    GridView {
        id: gridView
        x: 80
        y: 80
        width: 1024 - 80
        height: 600 - 80

        model: ListModel {
            ListElement {
                name: "Maps"
                icon: "../assets/mapsicon.png"
            }
            ListElement {
                name: "Video"
                icon: "../assets/videoplayericon.png"
            }
            ListElement {
                name: "Settings"
                icon: "../assets/settingsicon.png"
            }
            ListElement {
                name: "Light mode"
                icon: "../assets/daynight.png"
            }
            ListElement {
                name: "Turn off"
                icon: "../assets/officon.png"
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
        cellHeight: 236

    }
}
