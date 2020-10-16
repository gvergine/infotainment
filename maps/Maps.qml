import QtQuick 2.0
import QtLocation 5.6
import QtPositioning 5.6

Item
{


    id: root
    signal homeButton()

    Rectangle {
        anchors.fill: parent
        color: "#0000ff"
    }

    Plugin {
        id: mapPlugin
        name: "osm" // "mapboxgl", "esri", ...
        // specify plugin parameters if necessary
        // PluginParameter {
        //     name:
        //     value:
        // }
    }

    Map {
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(59.91, 10.75) // Oslo
        zoomLevel: 14
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




}
