import QtQuick 2.12
import QtQuick.Layouts 1.12

import "../videoplayer" as VideoPlayer

Item {

    id: root
    signal homeButton()
    StackLayout {
        id: layout
        anchors.fill: parent
        currentIndex: 0

        VideoPlayer.SelectVideo {
            onHomeButton: root.homeButton()
            onVideoSelected: {

                console.log(path)
                layout.currentIndex = 1
                videoScreen.video.stop()
                videoScreen.video.source = "file://" + path
                videoScreen.video.seek(0)
                videoScreen.video.play()

            }

        }

        VideoPlayer.VideoScreen {
            id: videoScreen
            onHomeButton: {
                video.pause()
                root.homeButton()
            }
            onBackButton: {
                console.log("Pausing")
                video.pause()
                layout.currentIndex = 0

            }


       }

    }


}
