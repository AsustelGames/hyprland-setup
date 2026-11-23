pragma Singleton

import Quickshell
import QtQuick


Singleton {
  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  readonly property string time: {
    Qt.formatDateTime(clock.date, "ddd MMM d hh:mm:ss AP yy")
  }
}
