import QtQuick
import Quickshell.Io
import "../../modules" as Modules

Item {
  id: root
  required property var screen

  implicitWidth: label.implicitWidth + 10
  implicitHeight: 22

  property int historyCount: 0

  Process {
    id: countProc
    command: ["/bin/bash", "-c", "dunstctl count history"]
    stdout: StdioCollector {
      onStreamFinished: {
        const n = parseInt(this.text.trim(), 10);
        root.historyCount = isNaN(n) ? 0 : n;
      }
    }
  }

  Timer {
    interval: 1000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: countProc.running = true
  }

  Text {
    id: label
    anchors.centerIn: parent
    text: (root.historyCount > 0 ? " " + root.historyCount : " ")
    color: Modules.Colors.border
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Modules.Panels.toggleNotifications(root.screen)
  }
}
