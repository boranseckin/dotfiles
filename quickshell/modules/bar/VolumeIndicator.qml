import QtQuick
import Quickshell.Services.Pipewire
import "../../modules" as Modules

Item {
  id: root
  required property var screen

  implicitWidth: label.implicitWidth + 6
  implicitHeight: 22

  readonly property var sink: Pipewire.defaultAudioSink
  readonly property real volume: sink && sink.audio ? sink.audio.volume : 0
  readonly property bool muted: sink && sink.audio ? sink.audio.muted : true

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink]
  }

  Text {
    id: label
    anchors.centerIn: parent
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    color: root.muted ? Modules.Colors.alert : Modules.Colors.border
    text: {
      if (root.muted)
        return "󰖁 " + Math.round(root.volume * 100) + "%";
      if (root.volume > 0.6)
        return "  " + Math.round(root.volume * 100) + "%";
      if (root.volume > 0.3)
        return " " + Math.round(root.volume * 100) + "%";
      return " " + Math.round(root.volume * 100) + "%";
    }
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton
    cursorShape: Qt.PointingHandCursor
    onClicked: Modules.Panels.toggleQuickSettings("volume", root.screen)
    onWheel: wheel => {
      if (!root.sink || !root.sink.audio)
        return;
      const step = 0.05;
      const delta = wheel.angleDelta.y > 0 ? step : -step;
      root.sink.audio.volume = Math.max(0, Math.min(1.5, root.sink.audio.volume + delta));
    }
  }
}
