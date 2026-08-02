import QtQuick
import Quickshell.Networking
import "../../modules" as Modules

Item {
  id: root
  required property var screen

  implicitWidth: label.implicitWidth + 6
  implicitHeight: 22

  readonly property var activeDevice: {
    const devices = Networking.devices.values;
    return devices.find(d => d.connected) || null;
  }

  readonly property var activeWifiNetwork: {
    if (!root.activeDevice || root.activeDevice.type !== DeviceType.Wifi)
      return null;
    return root.activeDevice.networks.values.find(n => n.connected) || null;
  }

  Text {
    id: label
    anchors.centerIn: parent
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    color: root.activeDevice ? Modules.Colors.border : Modules.Colors.alert
    text: {
      if (!root.activeDevice)
        return "󰀦 disconnected";
      if (root.activeDevice.type === DeviceType.Wired)
        return "󰈀 " + root.activeDevice.name;
      if (root.activeWifiNetwork)
        return "  " + root.activeWifiNetwork.name + " (" + Math.round(root.activeWifiNetwork.signalStrength) + "%)";
      return "  " + root.activeDevice.name;
    }
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: Modules.Panels.toggleQuickSettings("network", root.screen)
  }
}
