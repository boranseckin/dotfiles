import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../../modules" as Modules

RowLayout {
  id: root
  spacing: 10

  property real cpuPercent: 0
  property real ramPercent: 0

  property var _prevCpu: null

  FileView {
    id: statFile
    path: "/proc/stat"
  }

  FileView {
    id: memFile
    path: "/proc/meminfo"
  }

  Timer {
    interval: 2000
    running: true
    repeat: true
    triggeredOnStart: true
    onTriggered: root._sample()
  }

  function _sample() {
    const statLine = statFile.text().split("\n")[0];
    const parts = statLine.trim().split(/\s+/).slice(1).map(Number);
    const idle = parts[3] + parts[4];
    const total = parts.reduce((a, b) => a + b, 0);

    if (root._prevCpu) {
      const totalDelta = total - root._prevCpu.total;
      const idleDelta = idle - root._prevCpu.idle;
      if (totalDelta > 0) {
        root.cpuPercent = Math.max(0, Math.min(100, 100 * (1 - idleDelta / totalDelta)));
      }
    }
    root._prevCpu = {
      total,
      idle
    };

    const mem = {};
    for (const line of memFile.text().split("\n")) {
      const m = line.match(/^(\w+):\s+(\d+)/);
      if (m)
        mem[m[1]] = Number(m[2]);
    }
    if (mem.MemTotal && mem.MemAvailable) {
      root.ramPercent = 100 * (1 - mem.MemAvailable / mem.MemTotal);
    }
  }

  Text {
    text: "󰍛 " + Math.round(root.cpuPercent) + "%"
    color: root.cpuPercent > 85 ? Modules.Colors.alert : Modules.Colors.border
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
  }

  Text {
    text: "󰘚 " + Math.round(root.ramPercent) + "%"
    color: root.ramPercent > 85 ? Modules.Colors.alert : Modules.Colors.border
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
  }
}
