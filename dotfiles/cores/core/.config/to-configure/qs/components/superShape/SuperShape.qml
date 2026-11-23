import QtQuick
import QtQuick.Shapes

import "./components"

Shape {
  id: root

  implicitWidth: 50
  implicitHeight: 50

  property Corners corners: Corners {}

  Component.onCompleted: {
    console.log(corners.radius.effectiveX)
    console.log(corners.top.radius.effectiveX)
    console.log(corners.top.left.radius.effectiveX)
    console.log(corners.top.left.radius.all)
  }

  property string color: "white"
  property string borderColor: "white"
  property real borderWidth: 0

  //layer.enabled: true
  //layer.samples: 10

  //preferredRendererType: Shape.CurveRenderer
  ShapePath {
    fillColor: root.color
    strokeColor: "red"//root.borderColor//
    strokeWidth: 0//root.borderWidth

    // Start
    startX: root.corners.top.left.radius.effectiveX
    startY: 0

    PathLine { // Top line
      x: root.width - root.corners.top.right.radius.effectiveX
      y: 0
    }

    PathArc { // Top right arc
      x: root.width
      y: root.corners.top.right.radius.effectiveY
      radiusX: root.corners.top.right.radius.effectiveX
      radiusY: root.corners.top.right.radius.effectiveY

      direction: ! root.corners.top.right.invert ? PathArc.Clockwise : PathArc.Counterclockwise
    }

    PathLine { // Right line
      x: root.width
      y: root.height - root.corners.bottom.right.radius.effectiveY
    }

    PathArc { // Bottom right arc
      x: root.width - root.corners.bottom.right.radius.effectiveX
      y: root.height
      radiusX: root.corners.bottom.right.radius.effectiveX
      radiusY: root.corners.bottom.right.radius.effectiveY

      direction: ! root.corners.bottom.right.invert ? PathArc.Clockwise : PathArc.Counterclockwise
    }



    PathLine { // Bottom line
      x: root.corners.bottom.left.radius.effectiveX
      y: root.height
    }

    PathArc { // Bottom left arc
      x: 0
      y: root.height - root.corners.bottom.left.radius.effectiveY
      radiusX: root.corners.bottom.left.radius.effectiveX
      radiusY: root.corners.bottom.left.radius.effectiveY

      direction: ! root.corners.bottom.left.invert ? PathArc.Clockwise : PathArc.Counterclockwise
    }

    PathLine { // Left line
      x: 0
      y: root.corners.top.left.radius.effectiveY
    }

    PathArc { // Top left arc
      x: root.corners.top.left.radius.effectiveX
      y: 0
      radiusX: root.corners.top.left.radius.effectiveX
      radiusY: root.corners.top.left.radius.effectiveY

      direction: ! root.corners.top.left.invert ? PathArc.Clockwise : PathArc.Counterclockwise
    }

  }

}
