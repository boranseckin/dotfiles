import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "." as Modules
import "./bar" as Bar

PanelWindow {
  id: root
  required property var modelData
  screen: modelData

  WlrLayershell.layer: WlrLayer.Top
  WlrLayershell.namespace: "quickshell-bar"

  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 34
  margins {
    left: 6
    right: 6
    top: 6
  }

  color: "transparent"

  Rectangle {
    anchors.fill: parent
    radius: Modules.Colors.radius
    color: Modules.Colors.bg
    border.color: Modules.Colors.border
    border.width: 2

    RowLayout {
      anchors.fill: parent
      anchors.leftMargin: 12
      anchors.rightMargin: 12
      spacing: 16

      // ---- Left: workspaces ----
      Bar.Workspaces {
        Layout.alignment: Qt.AlignVCenter
      }

      // ---- Center: window title + now playing (fills remaining space) ----
      RowLayout {
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignVCenter
        spacing: 16

        Bar.WindowTitle {
          Layout.alignment: Qt.AlignVCenter
        }

        Item {
          Layout.fillWidth: true
        }

        Bar.Media {
          Layout.alignment: Qt.AlignVCenter
        }
      }

      // ---- Right: grouped status pills ----
      RowLayout {
        Layout.alignment: Qt.AlignVCenter
        spacing: 10

        // Rectangle {
        //   Layout.alignment: Qt.AlignVCenter
        //   implicitWidth: statsRow.implicitWidth + 16
        //   implicitHeight: 24
        //   radius: Modules.Colors.radius / 2
        //   color: Modules.Colors.bgAlt
        //
        //   RowLayout {
        //     id: statsRow
        //     anchors.centerIn: parent
        //     spacing: 12
        //     Bar.SystemResources {}
        //   }
        // }

        Rectangle {
          Layout.alignment: Qt.AlignVCenter
          visible: trayRow.implicitWidth > 0
          implicitWidth: trayRow.implicitWidth + 16
          implicitHeight: 24
          radius: Modules.Colors.radius / 2
          color: Modules.Colors.bgAlt

          RowLayout {
            id: trayRow
            anchors.centerIn: parent
            spacing: 10
            Bar.TrayIndicator {}
          }
        }

        Rectangle {
          Layout.alignment: Qt.AlignVCenter
          implicitWidth: quickRow.implicitWidth + 16
          implicitHeight: 24
          radius: Modules.Colors.radius / 2
          color: Modules.Colors.bgAlt

          RowLayout {
            id: quickRow
            anchors.centerIn: parent
            spacing: 12
            Bar.NetworkIndicator {
              screen: root.modelData
            }
            Bar.BluetoothIndicator {
              screen: root.modelData
            }
            Bar.VolumeIndicator {
              screen: root.modelData
            }
          }
        }

        Bar.NotificationBell {
          Layout.alignment: Qt.AlignVCenter
          screen: root.modelData
        }

        Bar.ClockIndicator {
          Layout.alignment: Qt.AlignVCenter
        }

        Bar.PowerButton {
          Layout.alignment: Qt.AlignVCenter
        }
      }
    }
  }
}
