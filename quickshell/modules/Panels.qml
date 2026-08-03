pragma Singleton
import QtQuick

QtObject {
  // Which flyout is open: "" | "quicksettings" | "notifications" | "calendar"
  property string open: ""
  // Active tab inside the quick settings flyout: "volume" | "network" | "bluetooth"
  property string quickSettingsTab: "volume"
  // Screen the currently open flyout should anchor to
  property var activeScreen: null

  function toggleQuickSettings(tab, screen) {
    if (open === "quicksettings" && quickSettingsTab === tab) {
      open = "";
    } else {
      quickSettingsTab = tab;
      activeScreen = screen;
      open = "quicksettings";
    }
  }

  function toggleNotifications(screen) {
    if (open === "notifications") {
      open = "";
    } else {
      activeScreen = screen;
      open = "notifications";
    }
  }

  function toggleCalendar(screen) {
    if (open === "calendar") {
      open = "";
    } else {
      activeScreen = screen;
      open = "calendar";
    }
  }

  function close() {
    open = "";
  }
}
