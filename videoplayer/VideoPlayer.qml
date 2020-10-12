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

                layout.currentIndex = 1


                var newPath = "file://" + path
                console.log(newPath)
                console.log(videoScreen.video.source)

                if (newPath.localeCompare(videoScreen.video.source) === 0)  {// continue video

                    videoScreen.video.play()

                } else {
                    videoScreen.video.stop()
                    videoScreen.video.source = newPath
                    videoScreen.video.seek(0)
                    videoScreen.video.play()
                }



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
