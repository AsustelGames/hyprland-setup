import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import "../mouseAreaBorder"


Item {
  id: root

  x: 0
  y: 0

  implicitWidth: resizeToTextWidth ? buttonText.implicitWidth : rect.implicitWidth
  implicitHeight: resizeToTextHeight ? buttonText.implicitHeight : rect.implicitHeight

  Layout.leftMargin: 13
  Layout.rightMargin: 13


  function determineColor(returnColorType: string, rawValues: string, overridingColors): string {
    var bgColor = "#31312E"
    var borderColor = "transparent"
    var fontColor = "white"
    var shadowColor = "black"

    var hovered = rawValues[0] === "1"
    var pressed = rawValues[1] === "1"
    var disabled = rawValues[2] === "1"
    var toggleable = rawValues[3] === "1"
    var toggled = rawValues[4] === "1"
    var overrideDefaultColors = rawValues[5] === "1"

    if (toggleable) {
      bgColor = "#31312E"
      borderColor = "transparent"
      shadowColor = "black"
      fontColor = "white"
    }

    if (toggleable && toggled) {
      bgColor = "green"
      borderColor = "green"
      shadowColor = "green"
      fontColor = "white"
    }

    if (hovered) {
      bgColor = "#222220"
      borderColor = "pink"
      shadowColor = "pink"
      fontColor = "pink"
    }

    if (toggleable && toggled && hovered) {
      bgColor = "#222220"
      borderColor = "lime"
      shadowColor = "lime"
      fontColor = "lime"
    }

    if (disabled) {
      bgColor = "#222220"
      borderColor = "transparent"
      shadowColor = "black"
      fontColor = "gray"
    }

    if (disabled && hovered) {
      bgColor = "#222220"
      borderColor = "red"
      shadowColor = "red"
      fontColor = "red"
    }

    if (overrideDefaultColors) {
      if (overridingColors[0] != "keep") {
        bgColor = String(overridingColors[0])
      }
      if (overridingColors[1] != "keep") {
        borderColor = String(overridingColors[1])
      }
      if (overridingColors[2] != "keep") {
        shadowColor = String(overridingColors[2])
      }
      if (overridingColors[3] != "keep") {
        fontColor = String(overridingColors[3])
      }
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

  property alias rect: rect
  property alias rectShadow: rectShadow
  property alias buttonText: buttonText
  property alias innerMouseArea: innerMouseArea
  property alias outerMouseArea: outerMouseArea
  property alias tooltipTimer: tooltipTimer

  // Button config
  property bool _hovering: false
  property bool _pressed: false
  property bool toggleButton: false
  property bool _toggled: false
  property bool disabled: false
  property bool disableOuterHoverArea: false
  property bool parentFocused: false

  property bool disableInnerMouseAreaMargins: false
  property bool showInnerMouseArea: false

  // Text
  property bool enableText: true
  property bool resizeToTextWidth: false
  property bool resizeToTextHeight: false

  // Tooltip
  property bool _showingTooltip: false
  property real _mouseX: 0
  property real _mouseY: 0

  // Animations
  property bool enableAnimations: true
  property bool disablePressAnimation: false
  property bool disableHoverAnimation: false
  property bool disableTextHoverAnimation: false

  // Shadow
  property bool enableShadow: true
  property real shadowSize: 6

  // Colors
  property bool overrideDefaultColors: false
  property var overridingColors: ["keep", "red", "keep", "red"]
  // property theme themefile:


  // Builtin signals
  signal canceled()
  signal clicked(MouseEvent mouse)
  signal doubleClicked(MouseEvent mouse)
  signal entered()
  signal exited()
  signal positionChanged(MouseEvent mouse)
  signal pressAndHold(MouseEvent mouse)
  signal pressed(MouseEvent mouse)
  signal released(MouseEvent mouse)
  signal wheel(WheelEvent wheel)

  // Custom signals
  signal toggled(bool toggled)
  signal tooltip(bool show, real mouseX, real mouseY)
  signal color(bool hovering, bool pressed, bool disabled, bool toggleButton, bool toggled)

  onParentFocusedChanged: {
    if (parentFocused) {
      root._hovering = false
    }
  }

  property string _determineColorRawValues:
    + String(_hovering ? 1 : 0)
    + String(_pressed ? 1 : 0)
    + String(disabled ? 1 : 0)
    + String(toggleButton ? 1 : 0)
    + String(_toggled ? 1 : 0)
    + String(overrideDefaultColors ? 1 : 0)
  
  on_DetermineColorRawValuesChanged: {
    color(_hovering, _pressed, disabled, toggleButton, _toggled)
  }


  // Button style & animations
  RectangularShadow {
    id: rectShadow

    anchors.fill: rect

    radius: rect.radius

    color: root.determineColor("shadow", root._determineColorRawValues, root.overridingColors)
    opacity: root.enableShadow ? 0.9 : 0.0

    blur: root.shadowSize
    spread: 1

    Behavior on color {
      ColorAnimation {
        duration: root.enableAnimations ? 250 : 0
        easing.type: Easing.OutCubic
      }
    }
  }

  Rectangle {
    id: rect

    anchors.fill: parent
    anchors.centerIn: parent
    anchors.margins: ! root._hovering ? -6 : root.disableHoverAnimation ? -6 : -8
    implicitWidth: 32
    implicitHeight: 32

    color: root.determineColor("bg", root._determineColorRawValues, root.overridingColors)
    radius: 10
    border.color: root.determineColor("border", root._determineColorRawValues, root.overridingColors)

    Behavior on anchors.margins {
      NumberAnimation {
        duration: root.enableAnimations ? 300 : 0
        easing.type: Easing.OutCubic
      }
    }
    Behavior on border.color {
      ColorAnimation {
        duration: root.enableAnimations ? 180 : 0
        easing.type: Easing.OutCubic
      }
    }
    Behavior on color {
      ColorAnimation {
        duration: root.enableAnimations ? 200 : 0
        easing.type: Easing.OutCubic
      }
    }

    Text {
      id: buttonText

      anchors.centerIn: parent

      color: root.enableText ? root.determineColor("font", root._determineColorRawValues, root.overridingColors) : "transparent"
      
      font.pointSize: 12
      font.family: root._hovered && ! root.disableTextHoverAnimation ? "DepartureMono Nerd Font" : "MartianMono Nerd Font"

      text: "Btn"

      Behavior on color {
        ColorAnimation {
          duration: root.enableAnimations ? 170 : 0
        }
      }

    }
  }

  on_ToggledChanged: {
    root.toggled(root._toggled)
  }

  on_PressedChanged: {
    if (root._pressed && ! root.disablePressAnimation) {
      root._hovering = false
    }
  }

  // Button interactions
  MouseArea {
    id: innerMouseArea

    anchors.fill: parent
    anchors.centerIn: parent
    anchors.margins: root.disableInnerMouseAreaMargins ? 0 : -3.5

    hoverEnabled: true

    property bool show: true

    onPositionChanged: (mouse) => {
      root._mouseX = mouse.x
      root._mouseY = mouse.y
      root.positionChanged(mouse)
    }

    onEntered: { 
      root.entered()
      root._hovering = true 
    }
    onExited: { 
      root.exited()
      if (root.disableOuterArea) { root._hovering = false } 
    }

    onPressed: (mouse) => { 
      root.pressed(mouse)
      if (! root.disabled) { root._pressed = true }
    }
    onReleased: (mouse) => {
      root.released(mouse)
      root._pressed = false
      if (root.toggleButton && root._toggled) {
        root._hovering = true
        root._toggled = false
      } else {
        root._hovering = true
        if (! root.disabled && root.toggleButton) {
          root._toggled = true
        }
      }
    }

    onCanceled: { root.canceled() }
    onClicked: (mouse) => { root.clicked(mouse) }
    onDoubleClicked: (mouse) => { root.doubleClicked(mouse) }
    onPressAndHold: (mouse) => { root.pressAndHold(mouse) }
    onWheel: (wheel) => { root.wheel(wheel) }

    Rectangle {
      anchors.fill: parent
      color: root.showInnerMouseArea ? "blue" : "transparent"
    }
  }

  MouseAreaBorder {
    id: outerMouseArea

    target: rect

    disableHover: root.disableOuterHoverArea

    onEntered: function() { if (! root.disableOuterArea) { root._hovering = false } }
    onExited: function() { if (! root.disableOuterArea) { root._hovering = false } }
  }


  // Tooltip handling
  on_HoveringChanged: {
    if (! root._hovering) {
      root._showingTooltip = false
      root.tooltip(root._showingTooltip, root._mouseX, root._mouseY)
    } else {
      if (! root._showingTooltip) { tooltipTimer.running = true }
    }
  }

  Timer {
    id: tooltipTimer

    running: false
    interval: 420
    
    onTriggered: {
      root._showingTooltip = true
      root.tooltip(root._showingTooltip, root._mouseX, root._mouseY)
    }
  }
}
