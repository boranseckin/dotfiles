import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../modules" as Modules

RowLayout {
  id: root
  spacing: 8

  property string submap: ""

  Connections {
    target: Hyprland
    function onRawEvent(event) {
      if (event.name === "submap") {
        root.submap = event.data;
      }
    }
  }

  Text {
    visible: root.submap.length > 0
    text: root.submap
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    font.italic: true
    color: Modules.Colors.border
  }

  Text {
    Layout.maximumWidth: 500
    elide: Text.ElideRight
    text: Hyprland.activeToplevel ? Hyprland.activeToplevel.title : ""
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    color: Modules.Colors.fg
  }
}
