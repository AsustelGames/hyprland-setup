import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import QtQuick.Effects

import "../../components/themedButton"

//finish icon config

Item {
  id: root

  implicitWidth: grid.implicitWidth
  implicitHeight: grid.implicitHeight

  Layout.leftMargin: 13
  Layout.rightMargin: 13


  function determineColor(returnColorType: string, rawValues: string): string {
    var bgColor = "transparent"
    var borderColor = "transparent"
    var rectBgColor = "#31312E"
    var rectBorderColor = "transparent"
    var shadowColor = "black"
    var fontColor = "transparent"

    var focused = rawValues[0] === "1"
    var cursorHovering = rawValues[1] === "1"
    var hasWindows = rawValues[2] === "1"
    var specialFocused = rawValues[3] === "1"
    var maxExceededAndLastItem = rawValues[4] === "1"
    var moduleFocused = rawValues[5] === "1"

    if (hasWindows) {
      bgColor = "green"
      borderColor = "transparent"
      fontColor = "white"
    } else {
      bgColor = "#43433E"
      borderColor = "transparent"
      fontColor = "#31312E"
    }
    if (hasWindows && cursorHovering) {
      bgColor = "lime"
      borderColor = "transparent"
      fontColor = "black"
    }

    if (! hasWindows && cursorHovering && ! focused) {
      bgColor = "transparent"
      borderColor = "pink"
      fontColor = "pink"
    }
    if (! hasWindows && cursorHovering && ! focused && specialFocused) {
      bgColor = "transparent"
      borderColor = "cyan"
      fontColor = "cyan"
    }

    if (focused) {
      bgColor = "pink"
      borderColor = "transparent"
      fontColor = "black"
    }

    if (focused && cursorHovering) {
      bgColor = "pink"
      borderColor = "transparent"
      fontColor = "black"
    }

    if (focused && specialFocused) {
      bgColor = "cyan"
      borderColor = "transparent"
      fontColor = "black"
    }
    
    if (maxExceededAndLastItem) {
      bgColor = "red"
      borderColor = "transparent"
      fontColor = "white"
    }
    if (maxExceededAndLastItem && specialFocused) {
      bgColor = "orange"
      borderColor = "transparent"
      shadowColor = "orange"
      fontColor = "black"
    }

    if (specialFocused) {
      rectBgColor = "#31312e"
      rectBorderColor = "cyan"
      shadowColor = "cyan"
    }

    if (maxExceededAndLastItem) {
      rectBgColor = "#31312e"
      rectBorderColor = "red"
      shadowColor = "red"
    }
    if (maxExceededAndLastItem && specialFocused) {
      rectBgColor = "#31312e"
      rectBorderColor = "orange"
      shadowColor = "orange"
    }
    if (_hovered) {
      rectBgColor = "#222220"
      rectBorderColor = "pink"
      shadowColor = "pink"
    }


    if (returnColorType === "bg") {
      return bgColor
    }
    if (returnColorType === "border") {
      return borderColor
    }
    if (returnColorType === "font") {
      return fontColor
    }

    if (returnColorType === "rectBorder") {
      return rectBorderColor
    }
    if (returnColorType === "shadow") {
      return shadowColor
    }

    return "red"
  }

  property alias button: button

  property bool _hovered: false
  property bool showIcon: true
  property string iconOverrride: ""
  property int maxDisplayedWorkspaces: 10

  property string determineRectColorRawValues: "000000"
  property var overridingColors: ["keep", determineColor("rectBorder", determineRectColorRawValues), determineColor("shadow", determineRectColorRawValues), "keep"]

  ThemedButton {
    id: button

    anchors.fill: parent
    anchors.centerIn: parent

    overrideDefaultColors: true
    overridingColors: root.overridingColors
    onColor: (hovering, pressed, disabled, toggleButton, toggled) => {
      root._hovered = hovering
    }

    disablePressAnimation: true
    enableText: false
  }


  GridLayout {
    id: grid

    rows: 2
    columns: root.maxDisplayedWorkspaces / 2

    rowSpacing: 4
    columnSpacing: 1

    Repeater {
      model: root.maxDisplayedWorkspaces

      ThemedButton {
        Layout.leftMargin: 0
        Layout.rightMargin: 0
        rect.anchors.margins: 0
        disableOuterHoverArea: true
        //enableShadow: focused || hovering ? true : false
        enableShadow: false
        disableInnerMouseAreaMargins: true

        property int id: index + 1
        property bool idIsMax: id === root.maxDisplayedWorkspaces

        property var workspaces: Hyprland.workspaces.values.find(
          w => w.id === id
        )
        property bool hasWindows: workspaces
          ? workspaces.toplevels.values.length > 0
          : false
        property bool focused: workspaces && workspaces.focused ? true : false

        property bool maxIdExceeded: idIsMax && focusedId > root.maxDisplayedWorkspaces
        property bool maxMax: idIsMax && maxIdExceeded
        property bool hovering: false

        property int focusedId: Hyprland.focusedWorkspace?.id ?? 0
        property bool specialFocused: false

        Connections {
          target: Hyprland

          function onRawEvent(event) {
            if (event.name === "activespecial")
              specialFocused = event.data.split(",")[0] !== ""
          }
        }

        transform: Translate {
          x: focused ? 3 : 0
          y: focused ? -2 : 0

          Behavior on x {
            NumberAnimation {
              duration: 150
              easing.type: Easing.Bezier
            }
          }
          Behavior on y {
            NumberAnimation {
              duration: 220
              easing.type: Easing.Bezier
            }
          }
        }
        implicitWidth: workspaces ? workspaces.focused ? 18 : 24 : 24
        implicitHeight: 14

        property string determineColorRawValues:
          + String(focused ? 1 : 0)
          + String(hovering ? 1 : 0)
          + String(hasWindows ? 1 : 0)
          + String(specialFocused ? 1 : 0)
          + String(maxMax ? 1 : 0)
          + String(root._hovered ? 1 : 0)

        onDetermineColorRawValuesChanged: {
          root.determineRectColorRawValues = determineColorRawValues
        }

        overrideDefaultColors: true
        overridingColors: [root.determineColor("bg", determineColorRawValues), root.determineColor("border", determineColorRawValues), root.determineColor("bg", determineColorRawValues), root.determineColor("font", determineColorRawValues)]
        rect.radius: workspaces ? workspaces.focused ? 6 : 4 : 2

        Behavior on implicitWidth {
          NumberAnimation {
            duration: 100
            easing.type: Easing.Linear
          }
        }
        Behavior on rect.color {
          ColorAnimation {
            duration: 170
          }
        }
        Behavior on rect.radius {
          NumberAnimation {
            duration: 150
            easing.type: Easing.Bezier
          }
        }
        Behavior on rect.border.color {
          ColorAnimation {
            duration: 200
            easing.type: Easing.OutCubic
          }
        }

        onEntered: {
          hovering = true
        }
        onExited: {
          hovering = false
        }

        onPressed: {
          hovering = false
        }
        onReleased: {
          hovering = true
        }

        onClicked: {
          if (workspaces) {
            workspaces.activate()
          } else {
            Hyprland.dispatch("hl.dsp.focus({ workspace = " + id + " })")
          }
        }

        buttonText.font.pointSize: 8
        buttonText.font.family: focused || maxIdExceeded ? "DepartureMono Nerd Font" : "MartianMono Nerd Font"
        buttonText.text: maxIdExceeded ? focusedId : id

      }
    }
  }

}
