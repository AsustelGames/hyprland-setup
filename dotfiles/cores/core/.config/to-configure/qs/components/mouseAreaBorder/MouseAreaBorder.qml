import QtQuick


Item {
  id: thisRoot

  required property var target

  property real thickness: 5
  property bool show: false

  property bool disableHover: false

  signal entered(int index)
  signal exited(int index)

  Repeater {
    model: 4

    MouseArea {
      hoverEnabled: thisRoot.disableHover ? false : true

      onEntered: thisRoot.entered(index)
      onExited: thisRoot.exited(index)

      x: index === 0 || index === 1
        ? thisRoot.target.anchors.leftMargin - 5 // Left + Top
        : index === 2
          ? thisRoot.target.width + thisRoot.target.anchors.rightMargin // Right
          : thisRoot.target.anchors.rightMargin - 5 // Bottom

      y: index === 0 || index === 1
        ? thisRoot.target.anchors.topMargin - 5 // Left + Top
        : index > 1 && index < 3
          ? thisRoot.target.anchors.bottomMargin - 5 // Right
          : thisRoot.target.height + thisRoot.target.anchors.bottomMargin // Bottom

      width: index === 0 || index === 2 ? thisRoot.thickness : thisRoot.target.width + 5
      height: index === 1 || index === 3 ? thisRoot.thickness : thisRoot.target.height + thisRoot. thickness + 5

      Rectangle {
        anchors.fill: parent
        color: thisRoot.show ? "red" : "transparent"
      }
    }
  }
}
