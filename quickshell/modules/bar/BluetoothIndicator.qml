import QtQuick
import Quickshell.Bluetooth
import "../../modules" as Modules

Item {
  id: root
  required property var screen

  implicitWidth: label.implicitWidth + 6
  implicitHeight: 22

  readonly property var adapter: Bluetooth.defaultAdapter
  readonly property var connectedDevices: adapter ? adapter.devices.values.filter(d => d.connected) : []

  Text {
    id: label
    anchors.centerIn: parent
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    color: (root.adapter && root.adapter.enabled) ? Modules.Colors.border : Modules.Colors.disabled
    text: {
      if (!root.adapter || !root.adapter.enabled)
        return "󰂯 off";
      if (root.connectedDevices.length === 0)
        return "󰂯 on";
      if (root.connectedDevices.length === 1) {
        const d = root.connectedDevices[0];
        return "󰂯 " + (d.batteryAvailable ? Math.round(d.battery * 100) + "%" : d.deviceName || d.name);
      }
      return "󰂯 " + root.connectedDevices.length + " connected";
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Modules.Panels.toggleQuickSettings("bluetooth", root.screen)
  }
}
