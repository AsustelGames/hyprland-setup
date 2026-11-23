import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.Wayland

PanelWindow {
  id: root

  property alias notifications: notificationsContainer

  WlrLayershell.layer: WlrLayer.Overlay
  exclusionMode: ExclusionMode.Ignore

  mask: Region {
  //item: bro
  }

  anchors {
    top: true
    right: true
    bottom: true
  }

  margins {
    top: 0
    bottom: 10
    right: root.barLeftOffset3
  }

  property real shadowWidth: 6
  property bool enableModuleShadow: true
  property real shadowWidth2: enableModuleShadow ? shadowWidth : 0
  property real barLeftOffset: 10
  property real barLeftOffset2: enableModuleShadow ? barLeftOffset - shadowWidth2 : 0
  property real shadowDifference: ! enableModuleShadow ? 1.5 : 0
  property real barLeftOffset3: barLeftOffset2 + shadowDifference

  implicitWidth: 350 + 35 + 6 + 1.5 + barLeftOffset + barLeftOffset2


  color: "transparent"
  //color: "pink"


  ColumnLayout {
    id: notificationsContainer
    x: root.shadowWidth2
    y: root.shadowWidth2

    spacing: 9

    Repeater {
      model: 1

      Item {
        property real notificationRectWidth: 350
        property real notificationRectHeight: 70

        implicitWidth: notificationRectWidth
        implicitHeight: notificationRectHeight

        RowLayout {
          spacing: 7

          Item { // notification Icon
            property real rectRadius: 10

            implicitWidth: parent.parent.height
            implicitHeight: parent.parent.height

            RectangularShadow {
              anchors.fill: parent

              radius: parent.rectRadius

              color: "black"//root.determineColor("shadow", root.determineRectColorRawValues)
              opacity: root.enableModuleShadow ? 0.9 : 0.0

              blur: root.shadowWidth2
              spread: 1
            }

            Rectangle {
              anchors.fill: parent

              color: "#222220"

              radius: parent.rectRadius
              border.color: "gray"
              border.width: 1.5
            }
          }
          Item { // notification Content
            property real rectRadius: 5

            property real contentRectWidth: 275
            property real contentRectHeight: parent.parent.height

            implicitWidth: contentRectWidth
            implicitHeight: contentRectHeight

            RectangularShadow {
              anchors.fill: parent

              radius: parent.rectRadius

              color: "black"//root.determineColor("shadow", root.determineRectColorRawValues)
              opacity: root.enableModuleShadow ? 0.9 : 0.0

              blur: root.shadowWidth2
              spread: 1
            }

            Rectangle {
              anchors.fill: parent

              color: "#222220" 

              radius: parent.rectRadius
              border.color: "gray"
              border.width: 1.5

              RowLayout {
                ColumnLayout {
                  Text {
                    text: "Title"
                    color: "white"
                    font.pointSize: 11
                    font.family: "Martian Nerd Font Bold"
                  }
                  Text {
                    text: "message"
                    color: "white"
                    font.pointSize: 11
                    font.family: "Martian Nerd Font Bold"
                  }
                }
              }

            }
          }
          Item {
            property real rectRadius: 5

            property real contentRectWidth: 35
            property real contentRectHeight: parent.parent.height

            implicitWidth: contentRectWidth
            implicitHeight: contentRectHeight

            RectangularShadow {
              anchors.fill: parent

              radius: parent.rectRadius

              color: "black"//root.determineColor("shadow", root.determineRectColorRawValues)
              opacity: root.enableModuleShadow ? 0.9 : 0.0

              blur: root.shadowWidth2
              spread: 1
            }

            Rectangle {
              anchors.fill: parent

              color: "#222220" 

              radius: parent.rectRadius
              border.color: "gray"
              border.width: 1.5

              Text {
                anchors.centerIn: parent
                text: "󱎘"
                color: "white"
                font.pointSize: 16
                font.family: "Martian Nerd Font Bold"
              }


            }
          } //

        }

      }

    }
  }

}
