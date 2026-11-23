import QtQuick
import QtQuick.Layouts
import QtQuick.Effects

import "./notificationSections"
import "../themedButton"

Item {
  implicitWidth: main.width //80 + 252 + 40 + 6 * 2
  implicitHeight: main.height //80 + 40 * 3 + 10 + 6 * 2

  Rectangle {
    anchors.fill: parent
    anchors.centerIn: parent

    anchors.margins: -10
    color: "pink"
    radius: 10
  }

  ColumnLayout {
    id: main

    spacing: 10
    RowLayout {
      spacing: 6
      IconSection {}
      ContentSection {}
      ColumnLayout {
        spacing: 6
        CloseButtonSection {}
        OpenButtonSection {}
      }
    }

    GridLayout {
      rows: 3
      columns: 3

      rowSpacing: 6
      columnSpacing: 6

      Repeater {
        model: 3
        ThemedButton {
          Layout.leftMargin: 0
          Layout.bottomMargin: 0
          Layout.rightMargin: index != 2 ? 6 : 0
          implicitWidth: index != 2 ? 0 : + 6
          Layout.fillWidth: true
          enableShadow: false
          rect.anchors.margins: 0
          disableInnerMouseAreaMargins: true
          showInnerMouseArea: true
        }
      }
    }
  }
}
