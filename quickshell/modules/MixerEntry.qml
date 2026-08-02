import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.Pipewire
import "." as Modules

ColumnLayout {
  id: root
  required property var node

  Layout.fillWidth: true
  spacing: 4

  readonly property string iconName: root.node.properties["application.icon-name"] ?? "audio-volume-high-symbolic"
  readonly property bool hasIcon: Quickshell.hasThemeIcon(iconName)

  PwObjectTracker {
    objects: [root.node]
  }

  RowLayout {
    Layout.fillWidth: true
    spacing: 8

    IconImage {
      visible: root.hasIcon
      implicitSize: 18
      source: root.hasIcon ? "image://icon/" + root.iconName : ""
    }

    Text {
      visible: !root.hasIcon
      text: "󰕾"
      color: Modules.Colors.disabled
      font.pixelSize: Modules.Colors.fontSize
    }

    Text {
      Layout.fillWidth: true
      elide: Text.ElideRight
      text: {
        const app = root.node.properties["application.name"] ?? (root.node.description !== "" ? root.node.description : root.node.name);
        const media = root.node.properties["media.name"];
        return media ? app + " - " + media : app;
      }
      color: Modules.Colors.fg
      font.family: Modules.Colors.fontFamily
      font.pixelSize: Modules.Colors.fontSize - 3
    }

    Text {
      text: root.node.audio.muted ? "󰝟" : "󰕾"
      color: Modules.Colors.fg
      font.pixelSize: Modules.Colors.fontSize

      MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.node.audio.muted = !root.node.audio.muted
      }
    }
  }

  RowLayout {
    Layout.fillWidth: true
    spacing: 8

    Text {
      Layout.preferredWidth: 34
      text: Math.round(root.node.audio.volume * 100) + "%"
      color: Modules.Colors.disabled
      font.family: Modules.Colors.fontFamily
      font.pixelSize: Modules.Colors.fontSize - 4
    }

    Slider {
      Layout.fillWidth: true
      from: 0
      to: 1.5
      value: root.node.audio.volume
      onMoved: root.node.audio.volume = value
    }
  }
}
