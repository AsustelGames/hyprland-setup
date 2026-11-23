import QtQuick


QtObject {
  id: root

  property VecAXY requestedRadius: VecAXY {}
  property VecAXY radius: VecAXY {
    x: root.requestedRadius.effectiveX != -1 ? root.requestedRadius.effectiveX : x != -1 ? x : 0
    y: root.requestedRadius.effectiveY != -1 ? root.requestedRadius.effectiveY : y != -1 ? y : 0
  }
  property bool requestedInvert: false
  property bool invert: requestedInvert ? true : false
  Component.onCompleted: {
    console.log("rex: " + radius.x + " " + "rey: " + radius.y)
    console.log("invert: " + invert)
  }
  //property int subDivision: -1
  //readonly property int effectiveSubDivision: subDivision > 0 ? subDivision < 4 ? subDivision : 3 : 1

  //property SubCorners requestedSub: SubCorners {}
  //property SubCorners sub: SubCorners {
  //  radius1.x: root.requestedSub.radius1.effectiveX != -1 ? root.requestedSub.radius1.effectiveX : radius1.x != -1 ? radius1.x : 0
  //  radius1.y: root.requestedSub.radius1.effectiveY != -1 ? root.requestedSub.radius1.effectiveY : radius1.y != -1 ? radius1.y : 0

  //  radius2.x: root.requestedSub.radius2.effectiveX != -1 ? root.requestedSub.radius2.effectiveX : radius2.x != -1 ? radius2.x : 0
  //  radius2.y: root.requestedSub.radius2.effectiveY != -1 ? root.requestedSub.radius2.effectiveY : radius2.y != -1 ? radius2.y : 0
  //}
}
