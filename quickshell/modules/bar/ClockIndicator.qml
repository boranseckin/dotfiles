import QtQuick
import QtQuick.Controls
import "../../modules" as Modules

Rectangle {
  id: root
  required property var screen

  implicitWidth: label.implicitWidth + 16
  implicitHeight: 22
  radius: Modules.Colors.radius
  color: Modules.Colors.border

  property date now: new Date()

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: root.now = new Date()
  }

  Text {
    id: label
    anchors.centerIn: parent
    text: Qt.formatDateTime(root.now, "ddd dd MMM hh:mm:ss")
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    color: Modules.Colors.bg
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Modules.Panels.toggleCalendar(root.screen)
  }
}
