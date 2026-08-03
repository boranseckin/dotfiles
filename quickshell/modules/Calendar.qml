import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import "." as Modules

PanelWindow {
  id: root
  required property var targetScreen

  screen: targetScreen
  visible: Modules.Panels.open === "calendar" && Modules.Panels.activeScreen === targetScreen

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

  implicitWidth: 300
  implicitHeight: card.contentHeight + 24
  color: "transparent"

  HyprlandFocusGrab {
    windows: [root]
    active: root.visible
    onCleared: Modules.Panels.close()
  }

  property date today: new Date()
  property int viewYear: today.getFullYear()
  property int viewMonth: today.getMonth()

  onVisibleChanged: if (visible) {
    today = new Date();
    viewYear = today.getFullYear();
    viewMonth = today.getMonth();
  }

  function daysInMonth(year, month) {
    return new Date(year, month + 1, 0).getDate();
  }

  function goPrevMonth() {
    if (viewMonth === 0) {
      viewMonth = 11;
      viewYear -= 1;
    } else {
      viewMonth -= 1;
    }
  }

  function goNextMonth() {
    if (viewMonth === 11) {
      viewMonth = 0;
      viewYear += 1;
    } else {
      viewMonth += 1;
    }
  }

  function buildCells() {
    const firstDay = (new Date(viewYear, viewMonth, 1).getDay() + 6) % 7;
    const numDays = daysInMonth(viewYear, viewMonth);
    const prevYear = viewMonth === 0 ? viewYear - 1 : viewYear;
    const prevMonth = viewMonth === 0 ? 11 : viewMonth - 1;
    const prevDays = daysInMonth(prevYear, prevMonth);

    const cells = [];
    for (let i = 0; i < firstDay; i++) {
      cells.push({
        day: prevDays - firstDay + 1 + i,
        current: false,
        isToday: false
      });
    }
    for (let d = 1; d <= numDays; d++) {
      cells.push({
        day: d,
        current: true,
        isToday: d === today.getDate() && viewMonth === today.getMonth() && viewYear === today.getFullYear()
      });
    }
    let next = 1;
    while (cells.length < 42) {
      cells.push({
        day: next,
        current: false,
        isToday: false
      });
      next += 1;
    }
    return cells;
  }

  readonly property var cells: buildCells()
  readonly property var monthNames: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
  readonly property var weekdayNames: ["Mo", "Tu", "We", "Th", "Fr", "Sa", "Su"]

  Rectangle {
    id: card
    x: 4
    y: 4
    width: parent.width - 8
    height: contentHeight
    radius: Modules.Colors.radius
    color: Modules.Colors.bg
    border.color: Modules.Colors.border
    border.width: 2

    readonly property real contentHeight: layout.implicitHeight + 24

    ColumnLayout {
      id: layout
      x: 12
      y: 12
      width: parent.width - 24
      spacing: 10

      RowLayout {
        Layout.fillWidth: true

        Text {
          text: "‹"
          color: Modules.Colors.fg
          font.family: Modules.Colors.fontFamily
          font.pixelSize: Modules.Colors.fontSize + 2
          font.bold: true
          MouseArea {
            anchors.fill: parent
            anchors.margins: -6
            cursorShape: Qt.PointingHandCursor
            onClicked: root.goPrevMonth()
          }
        }

        Text {
          Layout.fillWidth: true
          horizontalAlignment: Text.AlignHCenter
          text: root.monthNames[root.viewMonth] + " " + root.viewYear
          color: Modules.Colors.fg
          font.family: Modules.Colors.fontFamily
          font.pixelSize: Modules.Colors.fontSize
          font.bold: true

          MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
              root.viewYear = root.today.getFullYear();
              root.viewMonth = root.today.getMonth();
            }
          }
        }

        Text {
          text: "›"
          color: Modules.Colors.fg
          font.family: Modules.Colors.fontFamily
          font.pixelSize: Modules.Colors.fontSize + 2
          font.bold: true
          MouseArea {
            anchors.fill: parent
            anchors.margins: -6
            cursorShape: Qt.PointingHandCursor
            onClicked: root.goNextMonth()
          }
        }
      }

      GridLayout {
        Layout.fillWidth: true
        columns: 7
        rowSpacing: 4
        columnSpacing: 0

        Repeater {
          model: root.weekdayNames
          delegate: Text {
            required property string modelData
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            text: modelData
            color: Modules.Colors.disabled
            font.family: Modules.Colors.fontFamily
            font.pixelSize: Modules.Colors.fontSize - 4
            font.bold: true
          }
        }

        Repeater {
          model: root.cells
          delegate: Rectangle {
            required property var modelData
            Layout.fillWidth: true
            Layout.preferredHeight: 28
            radius: Modules.Colors.radius / 2
            color: modelData.isToday ? Modules.Colors.highlight : "transparent"

            Text {
              anchors.centerIn: parent
              text: modelData.day
              color: modelData.isToday ? Modules.Colors.bg : (modelData.current ? Modules.Colors.fg : Modules.Colors.disabled)
              font.family: Modules.Colors.fontFamily
              font.pixelSize: Modules.Colors.fontSize - 3
              font.bold: modelData.isToday
            }
          }
        }
      }
    }
  }
}
