import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Mpris
import "../../modules" as Modules

RowLayout {
  id: root
  spacing: 6
  visible: activePlayer !== null
  Layout.preferredWidth: visible ? implicitWidth : 0

  readonly property var activePlayer: {
    const players = Mpris.players.values;
    if (players.length === 0)
      return null;
    return players.find(p => p.isPlaying) || players[0];
  }

  // Text {
  //   text: root.activePlayer && root.activePlayer.canGoPrevious ? "󰒮" : ""
  //   color: Modules.Colors.border
  //   font.pixelSize: Modules.Colors.fontSize
  //   MouseArea {
  //     anchors.fill: parent
  //     cursorShape: Qt.PointingHandCursor
  //     onClicked: root.activePlayer && root.activePlayer.previous()
  //   }
  // }
  //
  // Text {
  //   text: root.activePlayer && root.activePlayer.isPlaying ? "󰏤" : "󰐊"
  //   color: Modules.Colors.highlight
  //   font.pixelSize: Modules.Colors.fontSize
  //   MouseArea {
  //     anchors.fill: parent
  //     cursorShape: Qt.PointingHandCursor
  //     onClicked: root.activePlayer && root.activePlayer.togglePlaying()
  //   }
  // }
  //
  // Text {
  //   text: root.activePlayer && root.activePlayer.canGoNext ? "󰒭" : ""
  //   color: Modules.Colors.border
  //   font.pixelSize: Modules.Colors.fontSize
  //   MouseArea {
  //     anchors.fill: parent
  //     cursorShape: Qt.PointingHandCursor
  //     onClicked: root.activePlayer && root.activePlayer.next()
  //   }
  // }

  Text {
    Layout.maximumWidth: 260
    elide: Text.ElideRight
    text: root.activePlayer ? (root.activePlayer.trackArtist ? root.activePlayer.trackArtist + " - " : "") + root.activePlayer.trackTitle : ""
    font.family: Modules.Colors.fontFamily
    font.pixelSize: Modules.Colors.fontSize
    color: Modules.Colors.fg
  }
}
