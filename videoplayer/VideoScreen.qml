import QtQuick 2.0
import QtMultimedia 5.12

Item {
    property alias video: video

    Video {
        id: video
        x:0
        y:0
        width : 1024
        height : 600

        MouseArea {
            anchors.fill: parent
            onClicked: {
                video.play()
            }
        }

        focus: true
        Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
        Keys.onLeftPressed: video.seek(video.position - 5000)
        Keys.onRightPressed: video.seek(video.position + 5000)
    }
}
