import QtQuick
import Quickshell.Io
import "../../modules" as Modules

Item {
  id: root
  implicitWidth: label.implicitWidth + 10
  implicitHeight: 22

  Process {
    id: proc
    command: ["/bin/bash", "-c", "$HOME/.config/hypr/scripts/power-controls.sh poweroff"]
  }

  Text {
    id: label
    anchors.centerIn: parent
    text: "⏻"
    color: Modules.Colors.border
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: proc.running = true
  }
}
