import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../modules" as Modules

RowLayout {
  id: root
  spacing: 4

  Repeater {
    model: Hyprland.workspaces

    delegate: Rectangle {
      id: ws
      required property var modelData

      width: 22
      height: 22
      radius: Modules.Colors.radius / 2
      color: modelData.focused ? Modules.Colors.highlight : modelData.urgent ? Modules.Colors.alert : "transparent"

      Text {
        anchors.centerIn: parent
        text: ws.modelData.name
        color: ws.modelData.focused ? Modules.Colors.bg : ws.modelData.urgent ? Modules.Colors.fg : Modules.Colors.border
        font.family: Modules.Colors.fontFamily
        font.pixelSize: Modules.Colors.fontSize - 2
        font.bold: ws.modelData.focused
      }

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: ws.modelData.activate()
      }
    }
  }
}
