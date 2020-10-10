import QtQuick 2.12

Item {

    id: root
    signal appSelected(int appId)

    GridView {
        id: gridView
        x: 80
        y: 80
        width: 1024 - 80
        height: 600 - 80
        clip: true

        model: ListModel {
            ListElement {
                name: "Maps"
                icon: "../assets/mapsicon.png"
                appId: 1
            }
            ListElement {
                name: "Video"
                icon: "../assets/videoplayericon.png"
                appId: 2
            }
            ListElement {
                name: "Settings"
                icon: "../assets/settingsicon.png"
                appId: 3
            }
            ListElement {
                name: "Light mode"
                icon: "../assets/daynight.png"
                appId: 4
            }
            ListElement {
                name: "Turn off"
                icon: "../assets/officon.png"
                appId: 5
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

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            root.appSelected(appId)
                        }
                    }
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
