import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import "." as Modules

PanelWindow {
  id: root
  required property var targetScreen

  screen: targetScreen
  visible: Modules.Panels.open === "notifications" && Modules.Panels.activeScreen === targetScreen

  WlrLayershell.layer: WlrLayer.Overlay
  WlrLayershell.keyboardFocus: visible ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

  anchors {
    top: true
    right: true
  }
  margins {
    top: 34
    right: 8
  }

  implicitWidth: 340
  implicitHeight: Math.min(500, card.contentHeight + 24)
  color: "transparent"

  HyprlandFocusGrab {
    windows: [root]
    active: root.visible
    onCleared: Modules.Panels.close()
  }

  property var entries: []

  onVisibleChanged: if (visible)
    refreshProc.running = true

  Process {
    id: refreshProc
    command: ["/bin/bash", "-c", "dunstctl history"]
    stdout: StdioCollector {
      onStreamFinished: {
        try {
          const parsed = JSON.parse(this.text);
          const list = (parsed.data && parsed.data[0]) ? parsed.data[0] : [];
          root.entries = list.slice().reverse();
        } catch (e) {
          root.entries = [];
        }
      }
    }
  }

  Process {
    id: clearProc
    command: ["/bin/bash", "-c", "dunstctl history-clear"]
  }

  function removeEntry(id) {
    removeProc.command = ["/bin/bash", "-c", "dunstctl history-rm " + id];
    removeProc.running = true;
  }

  Process {
    id: removeProc
    onRunningChanged: if (!running)
      refreshProc.running = true
  }

  Rectangle {
    id: card
    x: 4
    y: 4
    width: parent.width - 8
    height: Math.min(476, contentHeight)
    radius: Modules.Colors.radius
    color: Modules.Colors.bg
    border.color: Modules.Colors.border
    border.width: 2
    clip: true

    readonly property real emptyHeight: root.entries.length === 0 ? emptyText.implicitHeight + 8 : 0
    readonly property real contentHeight: header.implicitHeight + emptyHeight + list.contentHeight + 36

    ColumnLayout {
      id: layout
      x: 12
      y: 12
      width: parent.width - 24
      height: parent.height - 24
      spacing: 8

      RowLayout {
        id: header
        Layout.fillWidth: true

        Text {
          Layout.fillWidth: true
          text: "Notifications"
          color: Modules.Colors.fg
          font.family: Modules.Colors.fontFamily
          font.pixelSize: Modules.Colors.fontSize
          font.bold: true
        }

        Text {
          text: "Clear all"
          color: Modules.Colors.highlight
          font.family: Modules.Colors.fontFamily
          font.pixelSize: Modules.Colors.fontSize - 3
          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              clearProc.running = true;
              root.entries = [];
            }
          }
        }
      }

      Text {
        id: emptyText
        visible: root.entries.length === 0
        text: "No notifications"
        color: Modules.Colors.disabled
        font.family: Modules.Colors.fontFamily
        font.pixelSize: Modules.Colors.fontSize - 2
      }

      ListView {
        id: list
        Layout.fillWidth: true
        Layout.fillHeight: true
        clip: true
        spacing: 6
        model: root.entries

        delegate: Rectangle {
          required property var modelData
          width: list.width
          height: entryColumn.implicitHeight + 16
          radius: Modules.Colors.radius / 2
          color: Modules.Colors.bgAlt

          ColumnLayout {
            id: entryColumn
            x: 10
            y: 8
            width: parent.width - 20
            spacing: 2

            RowLayout {
              Layout.fillWidth: true

              Text {
                Layout.fillWidth: true
                elide: Text.ElideRight
                text: modelData.appname ? modelData.appname.data : ""
                color: Modules.Colors.highlight
                font.family: Modules.Colors.fontFamily
                font.pixelSize: Modules.Colors.fontSize - 3
                font.bold: true
              }

              Text {
                text: "×"
                color: Modules.Colors.alert
                font.pixelSize: Modules.Colors.fontSize
                MouseArea {
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  onClicked: root.removeEntry(modelData.id ? modelData.id.data : 0)
                }
              }
            }

            Text {
              Layout.fillWidth: true
              elide: Text.ElideRight
              text: modelData.summary ? modelData.summary.data : ""
              color: Modules.Colors.fg
              font.family: Modules.Colors.fontFamily
              font.pixelSize: Modules.Colors.fontSize - 3
            }

            Text {
              Layout.fillWidth: true
              visible: text.length > 0
              elide: Text.ElideRight
              maximumLineCount: 2
              wrapMode: Text.Wrap
              text: modelData.body ? modelData.body.data : ""
              color: Modules.Colors.disabled
              font.family: Modules.Colors.fontFamily
              font.pixelSize: Modules.Colors.fontSize - 4
            }
          }
        }
      }
    }
  }
}
