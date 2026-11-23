import QtQuick


QtObject {
  id: root

  property VecAXY radius: VecAXY {}
  property bool invert: false
  //property int subDivision: -1

  //property SubCorners sub: SubCorners {}

  property TopBottom top: TopBottom {
    requestedRadius: root.radius
    requestedInvert: root.invert
    //subDivision: root.subDivision
    //requestedSub: root.sub
  }
  property TopBottom bottom: TopBottom {
    requestedRadius: root.radius
    requestedInvert: root.invert
    //subDivision: root.subDivision
    //requestedSub: root.sub
  }
}
