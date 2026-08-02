import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.Pipewire
import Quickshell.Networking
import Quickshell.Bluetooth
import "." as Modules

PanelWindow {
  id: root
  required property var targetScreen

  screen: targetScreen
  visible: Modules.Panels.open === "quicksettings" && Modules.Panels.activeScreen === targetScreen

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

  implicitWidth: 320
  implicitHeight: inner.implicitHeight + 32
  color: "transparent"

  HyprlandFocusGrab {
    windows: [root]
    active: root.visible
    onCleared: Modules.Panels.close()
  }

  PwObjectTracker {
    objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
  }

  Rectangle {
    id: card
    x: 4
    y: 4
    width: parent.width - 8
    height: inner.implicitHeight + 24
    radius: Modules.Colors.radius
    color: Modules.Colors.bg
    border.color: Modules.Colors.border
    border.width: 2

    ColumnLayout {
      id: inner
      x: 12
      y: 12
      width: parent.width - 24
      spacing: 12

      RowLayout {
        id: tabRow
        Layout.fillWidth: true
        spacing: 8

        Repeater {
          model: [
            {
              key: "volume",
              label: "Volume"
            },
            {
              key: "network",
              label: "Network"
            },
            {
              key: "bluetooth",
              label: "Bluetooth"
            }
          ]

          delegate: Rectangle {
            required property var modelData
            Layout.fillWidth: true
            implicitHeight: 26
            radius: Modules.Colors.radius / 2
            color: Modules.Panels.quickSettingsTab === modelData.key ? Modules.Colors.highlight : Modules.Colors.bgAlt

            Text {
              anchors.centerIn: parent
              text: modelData.label
              color: Modules.Panels.quickSettingsTab === modelData.key ? Modules.Colors.bg : Modules.Colors.fg
              font.family: Modules.Colors.fontFamily
              font.pixelSize: Modules.Colors.fontSize - 2
            }

            MouseArea {
              anchors.fill: parent
              cursorShape: Qt.PointingHandCursor
              onClicked: Modules.Panels.quickSettingsTab = modelData.key
            }
          }
        }
      }

      ColumnLayout {
        id: tabContent
        Layout.fillWidth: true
        spacing: 10

        // ---- Volume ----
        ColumnLayout {
          visible: Modules.Panels.quickSettingsTab === "volume"
          Layout.fillWidth: true
          spacing: 10

          Text {
            text: "Output"
            color: Modules.Colors.disabled
            font.family: Modules.Colors.fontFamily
            font.pixelSize: Modules.Colors.fontSize - 3
          }

          RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
              text: (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio && Pipewire.defaultAudioSink.audio.muted) ? "󰖁" : ""
              color: Modules.Colors.fg
              font.pixelSize: Modules.Colors.fontSize + 2
              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                  const a = Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio;
                  if (a)
                    a.muted = !a.muted;
                }
              }
            }

            Slider {
              Layout.fillWidth: true
              from: 0
              to: 1.5
              value: (Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio) ? Pipewire.defaultAudioSink.audio.volume : 0
              onMoved: {
                const a = Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.audio;
                if (a)
                  a.volume = value;
              }
            }
          }

          Repeater {
            model: {
              const nodes = Pipewire.nodes.values;
              return nodes.filter(n => n.isSink && !n.isStream);
            }

            delegate: Rectangle {
              required property var modelData
              Layout.fillWidth: true
              implicitHeight: 26
              radius: Modules.Colors.radius / 2
              color: Pipewire.defaultAudioSink && Pipewire.defaultAudioSink.id === modelData.id ? Modules.Colors.bgAlt : "transparent"

              Text {
                anchors.left: parent.left
                anchors.leftMargin: 8
                anchors.verticalCenter: parent.verticalCenter
                elide: Text.ElideRight
                width: parent.width - 16
                text: (modelData.description || modelData.nickname || modelData.name)
                color: Modules.Colors.fg
                font.family: Modules.Colors.fontFamily
                font.pixelSize: Modules.Colors.fontSize - 3
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: Pipewire.preferredDefaultAudioSink = modelData
              }
            }
          }

          Text {
            visible: appMixerRepeater.count > 0
            text: "Applications"
            color: Modules.Colors.disabled
            font.family: Modules.Colors.fontFamily
            font.pixelSize: Modules.Colors.fontSize - 3
          }

          PwNodeLinkTracker {
            id: sinkLinkTracker
            node: Pipewire.defaultAudioSink
          }

          Repeater {
            id: appMixerRepeater
            model: sinkLinkTracker.linkGroups

            delegate: Modules.MixerEntry {
              required property var modelData
              node: modelData.source
            }
          }

          Text {
            text: "Input"
            color: Modules.Colors.disabled
            font.family: Modules.Colors.fontFamily
            font.pixelSize: Modules.Colors.fontSize - 3
          }

          RowLayout {
            Layout.fillWidth: true
            spacing: 8

            Text {
              text: (Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio && Pipewire.defaultAudioSource.audio.muted) ? "󰍭" : "󰍬"
              color: Modules.Colors.fg
              font.pixelSize: Modules.Colors.fontSize + 2
              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                  const a = Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio;
                  if (a)
                    a.muted = !a.muted;
                }
              }
            }

            Slider {
              Layout.fillWidth: true
              from: 0
              to: 1.5
              value: (Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio) ? Pipewire.defaultAudioSource.audio.volume : 0
              onMoved: {
                const a = Pipewire.defaultAudioSource && Pipewire.defaultAudioSource.audio;
                if (a)
                  a.volume = value;
              }
            }
          }
        }

        // ---- Network ----
        ColumnLayout {
          visible: Modules.Panels.quickSettingsTab === "network"
          Layout.fillWidth: true
          spacing: 8

          RowLayout {
            Layout.fillWidth: true

            Text {
              Layout.fillWidth: true
              text: "Wi-Fi"
              color: Modules.Colors.fg
              font.family: Modules.Colors.fontFamily
              font.pixelSize: Modules.Colors.fontSize - 1
            }

            Switch {
              checked: Networking.wifiEnabled
              onToggled: Networking.wifiEnabled = checked
            }
          }

          Repeater {
            model: {
              const devices = Networking.devices.values;
              const wifi = devices.find(d => d.type === DeviceType.Wifi);
              return wifi ? wifi.networks.values : [];
            }

            delegate: ColumnLayout {
              required property var modelData
              Layout.fillWidth: true
              spacing: 4

              Rectangle {
                Layout.fillWidth: true
                implicitHeight: 28
                radius: Modules.Colors.radius / 2
                color: modelData.connected ? Modules.Colors.bgAlt : "transparent"

                RowLayout {
                  anchors.fill: parent
                  anchors.leftMargin: 8
                  anchors.rightMargin: 8

                  Text {
                    Layout.fillWidth: true
                    elide: Text.ElideRight
                    text: modelData.name
                    color: modelData.connected ? Modules.Colors.highlight : Modules.Colors.fg
                    font.family: Modules.Colors.fontFamily
                    font.pixelSize: Modules.Colors.fontSize - 3
                  }

                  Text {
                    text: Math.round(modelData.signalStrength) + "%"
                    color: Modules.Colors.disabled
                    font.pixelSize: Modules.Colors.fontSize - 4
                  }
                }

                MouseArea {
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  onClicked: {
                    if (modelData.connected)
                      return;
                    if (modelData.known || modelData.security === WifiSecurityType.Open) {
                      modelData.connect();
                    } else {
                      pskField.visible = !pskField.visible;
                    }
                  }
                }
              }

              RowLayout {
                id: pskField
                visible: false
                Layout.fillWidth: true

                TextField {
                  id: pskInput
                  Layout.fillWidth: true
                  placeholderText: "Password"
                  echoMode: TextInput.Password
                }

                Button {
                  text: "Connect"
                  onClicked: {
                    modelData.connectWithPsk(pskInput.text);
                    pskField.visible = false;
                  }
                }
              }
            }
          }
        }

        // ---- Bluetooth ----
        ColumnLayout {
          visible: Modules.Panels.quickSettingsTab === "bluetooth"
          Layout.fillWidth: true
          spacing: 8

          RowLayout {
            Layout.fillWidth: true

            Text {
              Layout.fillWidth: true
              text: "Bluetooth"
              color: Modules.Colors.fg
              font.family: Modules.Colors.fontFamily
              font.pixelSize: Modules.Colors.fontSize - 1
            }

            Switch {
              checked: Bluetooth.defaultAdapter ? Bluetooth.defaultAdapter.enabled : false
              onToggled: if (Bluetooth.defaultAdapter)
                Bluetooth.defaultAdapter.enabled = checked
            }
          }

          Repeater {
            model: Bluetooth.defaultAdapter ? Bluetooth.defaultAdapter.devices.values : []

            delegate: Rectangle {
              required property var modelData
              Layout.fillWidth: true
              implicitHeight: 28
              radius: Modules.Colors.radius / 2
              color: modelData.connected ? Modules.Colors.bgAlt : "transparent"

              RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 8
                anchors.rightMargin: 8

                Text {
                  Layout.fillWidth: true
                  elide: Text.ElideRight
                  text: modelData.deviceName || modelData.name
                  color: modelData.connected ? Modules.Colors.highlight : Modules.Colors.fg
                  font.family: Modules.Colors.fontFamily
                  font.pixelSize: Modules.Colors.fontSize - 3
                }

                Text {
                  visible: modelData.batteryAvailable
                  text: Math.round(modelData.battery * 100) + "%"
                  color: Modules.Colors.disabled
                  font.pixelSize: Modules.Colors.fontSize - 4
                }
              }

              MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: modelData.connected ? modelData.disconnect() : modelData.connect()
              }
            }
          }
        }
      }
    }
  }
}
