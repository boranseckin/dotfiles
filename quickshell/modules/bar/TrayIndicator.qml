import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "../../modules" as Modules

RowLayout {
  id: root
  spacing: 10

  Repeater {
    model: SystemTray.items

    delegate: Item {
      id: trayItem
      required property var modelData

      implicitWidth: 18
      implicitHeight: 18

      IconImage {
        anchors.fill: parent
        source: trayItem.modelData.icon
      }

      QsMenuAnchor {
        id: menuAnchor
        menu: trayItem.modelData.menu
        anchor.item: trayItem
        anchor.edges: Edges.Bottom
        anchor.gravity: Edges.Bottom
      }

      MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor
        onClicked: mouse => {
          if (mouse.button === Qt.RightButton && trayItem.modelData.hasMenu) {
            if (menuAnchor.visible) {
              menuAnchor.close();
            } else {
              menuAnchor.open();
            }
          } else {
            trayItem.modelData.activate();
          }
        }
      }
    }
  }
}
