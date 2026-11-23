import QtQuick


QtObject {
  property real all: -1
  property real x: -1
  property real y: -1

  readonly property real effectiveX: all != -1 ? all : x != -1 ? x : 0
  readonly property real effectiveY: all != -1 ? all : y != -1 ? y : 0
}
