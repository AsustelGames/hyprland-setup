import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import "../../components/themedButton"


Item {
  id: root

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  Layout.leftMargin: 13
  Layout.rightMargin: 13


  function determineColor(returnColorType: string, rawValues: string): string {
    var bgColor = "transparent"
    var borderColor = "transparent"
    var shadowColor = "transparent"
    var fontColor = "transparent"

    var toggled = rawValues[0] === "1"
    var cursorHovering = rawValues[1] === "1"
    var newMessageReceived = rawValues[2] === "1"
    var hasMessages = rawValues[3] === "1"

    if (hasMessages) {
      bgColor = "#31312e"
      borderColor = "transparent"
      shadowColor = "black"
      fontColor = "white"
    } else {
      bgColor = "#31312e"
      borderColor = "transparent"
      shadowColor = "black"
      fontColor = "#43433F"
    }

    if (newMessageReceived) {
      bgColor = "cyan"
      borderColor = "cyan"
      shadowColor = "cyan"
      fontColor = "black"
    }

    if (cursorHovering) {
      bgColor = "#222220"
      borderColor = "pink"
      shadowColor = "pink"
      fontColor = "pink"
    }

    if (cursorHovering && newMessageReceived) {
      bgColor = "#222220"
      borderColor = "cyan"
      shadowColor = "cyan"
      fontColor = "cyan"
    }

    if (toggled) {
      bgColor = "green"
      borderColor = "green"
      shadowColor = "green"
      fontColor = "white"
    }
    if (toggled && cursorHovering) {
      bgColor = "#222220"
      borderColor = "lime"
      shadowColor = "lime"
      fontColor = "lime"
    }


    if (returnColorType === "bg") {
      return bgColor
    }
    if (returnColorType === "border") {
      return borderColor
    }
    if (returnColorType === "shadow") {
      return shadowColor
    }
    if (returnColorType === "font") {
      return fontColor
    }

    return "red"
  }

  property alias button: button

  property bool _hovered: false
  property bool _toggled: false

  property int notificationCount: 0
  property bool newMessageReceived: false


  property string determineColorRawValues:
    + String(_toggled ? 1 : 0)
    + String(_hovered ? 1 : 0)
    + String(newMessageReceived ? 1 : 0)
    + String(notificationCount > 0 ? 1 : 0)

  property var overridingColors: [determineColor("bg", determineColorRawValues), determineColor("border", determineColorRawValues), determineColor("shadow", determineColorRawValues), determineColor("font", determineColorRawValues)]

  ThemedButton {
    id: button

    anchors.fill: parent
    anchors.centerIn: parent

    overrideDefaultColors: true
    overridingColors: root.overridingColors
    onColor: (hovering, pressed, disabled, toggleButton, toggled) => {
      root._hovered = hovering
      root._toggled = toggled
    }

    toggleButton: true

    rect.anchors.margins: ! root._hovered ? -8 : -10
    rect.radius: 5

    resizeToTextWidth: true
    resizeToTextHeight: true

    buttonText.text: root.notificationCount > 9 ? " 9+" : " " + String(root.notificationCount)
  }
}
