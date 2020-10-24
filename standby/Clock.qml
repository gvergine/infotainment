import QtQuick 2.0

Item {
    id : clock
    width: 200;
    height: 200;


    property int hours
    property int minutes
    property int seconds

    function timeChanged() {
        var date = new Date;
        hours = date.getHours()
        minutes = date.getMinutes()
        seconds = date.getUTCSeconds();
    }


    Timer {
        id: timer
        interval: 100; running: true; repeat: true;
        onTriggered: clock.timeChanged()
    }

    Item {
        anchors.centerIn: parent
        width: 200; height: 200

        Image {
            source: "../assets/clock-night.png";
        }

        Image {
            x: 92.5; y: 27
            source: "../assets/hour.png"
            transform: Rotation {
                id: hourRotation
                origin.x: 7.5; origin.y: 73;
                angle: (clock.hours * 30) + (clock.minutes * 0.5)
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }

        Image {
            x: 93.5; y: 17
            source: "../assets/minute.png"
            transform: Rotation {
                id: minuteRotation
                origin.x: 6.5; origin.y: 83;
                angle: clock.minutes * 6
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }

        Image {
            x: 97.5; y: 20
            source: "../assets/second.png"
            transform: Rotation {
                id: secondRotation
                origin.x: 2.5; origin.y: 80;
                angle: clock.seconds * 6
                Behavior on angle {
                    SpringAnimation { spring: 2; damping: 0.2; modulus: 360 }
                }
            }
        }



    }
}
