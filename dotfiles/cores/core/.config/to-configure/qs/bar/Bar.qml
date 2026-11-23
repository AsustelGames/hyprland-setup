import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
import Quickshell.Wayland
import QtQuick.Shapes

import "./modules"
import "../components/notifications"
import "../components/superShape"


Scope {
  id: root

  //property alias window: windowRoot
  property var parentReference
  property var windows: []

  function sendValueTo(name, value) {
    parentReference[name] = value
  }

  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: windowRoot

      required property var modelData
      screen: modelData

      Component.onCompleted: {
        root.windows.push(this)
      }

      onWidthChanged: {
        root.sendValueTo("bar_window_width", width)
      }
      onHeightChanged: {
        root.sendValueTo("bar_window_height", height)
      }

      WlrLayershell.layer: WlrLayer.Top

      anchors {
        top: true
        left: true
        right: true
      }

      color: "transparent"


      property bool barHovered: false
      
      RectangularShadow {
        anchors.fill: bar

        radius: bar.radius

        color: "black"
        opacity: 0.9

        blur: 8
        spread: 1
      }

      Rectangle {
        id: bar

        anchors {
          fill: parent
          top: parent.top
          topMargin: 10
          bottomMargin: 8
          leftMargin: 10
          rightMargin: 10
        }

        color: "#222220"
        radius: 10
        border.color: "gray"
        border.width: 1.5
      }

      MouseArea {
        anchors.fill: bar

        hoverEnabled: true

        onEntered: windowRoot.barHovered = true
        onExited: windowRoot.barHovered = false
      }

      SuperShape {

      }

      implicitHeight: 60 + 8 + 10// + 100


      Item {
        anchors.fill: bar

        RowLayout { // Left
          spacing: 0
          anchors.left: parent.left
          anchors.verticalCenter: parent.verticalCenter

          Workspaces {
            Layout.leftMargin: 15
            button.parentFocused: windowRoot.barHovered
          }

        }
        RowLayout { // Center
          spacing: 0
          anchors.horizontalCenter: parent.horizontalCenter
          anchors.verticalCenter: parent.verticalCenter

          SuperShape {
            //corners.radius.all: 10
            //corners.top.radius.all: 20
            //corners.top.left.radius.all: 30
            //corners.top.left.invert: true
            //borderWidth: 10
          }

        }
        RowLayout { // Right
          spacing: 3
          anchors.right: parent.right
          anchors.verticalCenter: parent.verticalCenter

          Clock {
            Layout.rightMargin: 8
            button.parentFocused: windowRoot.barHovered

          }

          NotificationButton {
            Layout.rightMargin: 18
            button.parentFocused: windowRoot.barHovered
          }

          //Notification {
          //  Layout.rightMargin: 50
          //}

        }
      }

    }
  }
  
}
