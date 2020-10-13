import QtQuick 2.0
import QtMultimedia 5.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    id: root
    signal homeButton()
    signal backButton()

    property alias video: video



    Video {
        id: video
        x:0
        y:0
        width : 1024
        height : 600

        onSourceChanged: {
            titleText.text = source.toString().split('/').pop().split('#')[0].split('?')[0];
        }

        Component.onCompleted: {
            notifyInterval = 15
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            }
        }

        onPositionChanged: {
            progressTime.value = position
            timeText.text = millisToMinutesAndSeconds(position) + "/" + millisToMinutesAndSeconds(duration)
        }

        onPaused: {
            console.log("paused")
            controlsVisible(true)

        }

        onPlaying: {
            console.log("playing")
            controlsVisible(false)

        }

        onStopped: {
            console.log("stopped")
            controlsVisible(true)
        }

        focus: true

    }

    function millisToMinutesAndSeconds(millis) {
      var minutes = Math.floor(millis / 60000);
      var seconds = ((millis % 60000) / 1000).toFixed(0);
      return minutes + ":" + (seconds < 10 ? '0' : '') + seconds;
    }

    function controlsVisible(visibility)
    {
        background.opacity = visibility ? 1 : 0
        homeIcon.opacity = visibility? 1 : 0
        backIcon.opacity = visibility? 1 : 0
        progressTime.opacity = visibility? 1 : 0
        timeText.opacity = visibility? 1 : 0
        titleText.opacity = visibility? 1 : 0
    }



    Rectangle {
        id: background
        y: 0
        x: 0
        width: 1024
        height: 600
        opacity: 1

        gradient: Gradient {
            GradientStop { position: 0.0; color: "#ff000000" }
            GradientStop { position: 0.2; color: "#00000000" }
            GradientStop { position: 0.8; color: "#00000000" }
            GradientStop { position: 1.0; color: "#ff000000" }
        }


        Behavior on opacity {
            NumberAnimation { duration: 100 }
        }
    }

    Image {
        id: homeIcon
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


        Behavior on opacity {
            NumberAnimation { duration: 100 }
        }
    }

     Image {
           id: backIcon
           x:20
           y:500
           width: 64
           height: 64
           source: "../assets/backicon.png"

           MouseArea {
               anchors.fill: parent
               onClicked: {
                   root.backButton()
               }
           }


           Behavior on opacity {
               NumberAnimation { duration: 100 }
           }
       }


     Slider {
         id: progressTime
         x:100
         y:500
         width: 900
         height: 64
         from: 0
         value: 0
         to: video.duration

         onMoved: {
             video.seek(value)
             if(video.playbackState !== MediaPlayer.PausedState) {
                 video.pause()
             }
         }



         background: Rectangle {
               x: progressTime.leftPadding
               y: progressTime.topPadding + progressTime.availableHeight / 2 - height / 2
               implicitWidth: 200
               implicitHeight: 4
               width: progressTime.availableWidth
               height: implicitHeight
               radius: 2
               color: "#ffffff"

               Rectangle {
                   width: progressTime.visualPosition * parent.width
                   height: parent.height
                   color: "#ff0000"
                   radius: 2
               }
           }

           handle: Rectangle {
               x: progressTime.leftPadding + progressTime.visualPosition * (progressTime.availableWidth - width)
               y: progressTime.topPadding + progressTime.availableHeight / 2 - height / 2
               implicitWidth: 26
               implicitHeight: 26
               radius: 13
               color: "#ffffff"
               border.color: "#ffffff"
           }

           Behavior on opacity {
               NumberAnimation { duration: 100 }
           }
     }

     Text {
         id: timeText
         x:800
         y:20
         width: 200
         height: 64
         text: "--:--:--/--:--:--0"
         color: "#ffffff"
         font.pointSize: 20
         font.weight: Font.Thin
         font.family: "Helvetica"
         horizontalAlignment: Text.AlignRight


         Behavior on opacity {
             NumberAnimation { duration: 100 }
         }
     }

     Text {
         id: titleText
         x:150
         y:20
         width: 720
         height: 64
         text: "--"
         color: "#ffffff"
         font.pointSize: 20
         font.weight: Font.Thin
         font.family: "Helvetica"
         horizontalAlignment: Text.AlignLeft
         elide: Text.ElideRight




         Behavior on opacity {
             NumberAnimation { duration: 100 }
         }
     }


}
