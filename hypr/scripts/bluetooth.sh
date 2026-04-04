#!/bin/bash

get_power_status() {
  if bluetoothctl show | grep -q "Powered: yes"; then
    echo "On"
  else
    echo "Off"
  fi
}

get_scan_status() {
  if bluetoothctl show | grep -q "Discovering: yes"; then
    echo "On"
  else
    echo "Off"
  fi
}

notify() {
  if command -v notify-send &>/dev/null; then
    notify-send "Bluetooth" "$1"
  fi
}

POWER_STATUS=$(get_power_status)
SCAN_STATUS=$(get_scan_status)

if [ "$POWER_STATUS" = "On" ]; then
  POWER_OPT="Power: Turn Off"
else
  POWER_OPT="Power: Turn On"
fi

if [ "$SCAN_STATUS" = "On" ]; then
  SCAN_OPT="Scan: Stop Scanning"
else
  SCAN_OPT="Scan: Start Scanning"
fi

OPTIONS="$POWER_OPT\n$SCAN_OPT\nDevices"

# Show Main Menu
SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -p bluetooth)

case "$SELECTED" in
"Power: Turn On")
  bluetoothctl power on
  notify "Bluetooth Powered On"
  ;;
"Power: Turn Off")
  bluetoothctl power off
  notify "Bluetooth Powered Off"
  ;;
"Scan: Start Scanning")
  bluetoothctl scan on >/dev/null 2>&1 &
  notify "Scanning Started"
  ;;
"Scan: Stop Scanning")
  bluetoothctl scan off
  notify "Scanning Stopped"
  ;;
"Devices")
  DEVICES=$(bluetoothctl devices | sed 's/Device //')

  if [ -z "$DEVICES" ]; then
    notify "No devices found."
    exit 0
  fi

  SELECTED_DEVICE=$(echo "$DEVICES" | rofi -dmenu -p "Select Device")

  MAC=$(echo "$SELECTED_DEVICE" | awk '{print $1}')
  NAME=$(echo "$SELECTED_DEVICE" | cut -d ' ' -f 2-)

  if [ -n "$MAC" ]; then
    ACTIONS="Connect\nDisconnect\nPair\nRemove\nInfo"
    ACTION=$(echo -e "$ACTIONS" | rofi -dmenu -p "$NAME")

    case "$ACTION" in
    "Connect")
      notify "Connecting to $NAME..."
      bluetoothctl connect "$MAC"
      notify "Finished attempting connection to $NAME"
      ;;
    "Disconnect")
      bluetoothctl disconnect "$MAC"
      notify "Disconnected from $NAME"
      ;;
    "Pair")
      notify "Pairing with $NAME..."
      bluetoothctl pair "$MAC"
      ;;
    "Remove")
      bluetoothctl remove "$MAC"
      notify "Removed $NAME"
      ;;
    "Info")
      INFO=$(bluetoothctl info "$MAC")
      notify-send "Info: $NAME" "$INFO"
      ;;
    esac
  fi
  ;;
esac
