import Quickshell

import "./bar"
import "./notifications"


Scope {
  id: shell

  property real heightOffset
  property real bar_window_height: 0
  property real bar_window_width: 0

  Bar { parentReference: shell }
  //NotificationManager { margins.top: bar_window_height }
}
