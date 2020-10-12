import QtQuick 2.12
import QtQml.Models 2.2

Item {

    id: root
    signal homeButton()
    signal videoSelected(string path)
    //signal backButton()

    Rectangle {
        anchors.fill: parent
        color: "#000000"
    }

    Image {
        x:20
        y:20
        width: 64
        height: 64
        source: "../assets/homeicon.png"

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.homeButton()
            }
        }
    }

    Text {
        x: 160
        y: 25
        text: "Select video"
        color: "#ffffff"
        font.pointSize: 35
        font.weight: Font.Thin
        font.family: "Helvetica"
    }

    ListView {
        id: listView
        objectName: "selectVideoListView"
        x: 20
        y: 100
        width: 1024 - 50
        height: 600 - 140
        boundsBehavior: Flickable.StopAtBounds
        clip: true
        snapMode: ListView.SnapToItem

        model: fsm



        delegate: Item {
            id: item
            x: 5
            height: 80

            Rectangle {
                width: listView.width - 10
                height: item.height
                color: "#aaaaaa"
                radius: 10

                Text {
                    text: fileName
                    color: "#333333"
                    font.pointSize: 20
                    font.weight: Font.Thin
                    font.family: "Helvetica"
                    anchors.verticalCenter: parent.verticalCenter
                    leftPadding: 10
                    clip: true
                    width: listView.width - 10
                    elide: Text.ElideRight
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        if (isDir)
                            listView.model.select(path)
                        else
                            root.videoSelected(path)

                    }
                }

            }

       }

       spacing: 10

    }


}
