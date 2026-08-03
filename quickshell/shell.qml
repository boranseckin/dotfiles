//@ pragma UseQApplication
import QtQml
import Quickshell
import "./modules" as Modules

ShellRoot {
  Variants {
    model: Quickshell.screens

    delegate: Component {
      Modules.Bar {}
    }
  }

  Variants {
    model: Quickshell.screens

    delegate: Component {
      Modules.QuickSettings {
        required property var modelData
        targetScreen: modelData
      }
    }
  }

  Variants {
    model: Quickshell.screens

    delegate: Component {
      Modules.NotificationHistory {
        required property var modelData
        targetScreen: modelData
      }
    }
  }

  Variants {
    model: Quickshell.screens

    delegate: Component {
      Modules.Calendar {
        required property var modelData
        targetScreen: modelData
      }
    }
  }
}
