#!/bin/bash
set -e

function select_action() {
  ACTION=$(printf "poweroff\nreboot\nlogout\nclose apps" | rofi -dmenu -p power)
}

function grub() {
  SELECTION=$(cat /boot/grub/grub.cfg | grep "^menuentry" | awk -F\' '{print $2}' | rofi -dmenu -p grub -sort)
  notify-send "power controls" "$SELECTION is selected for next boot"
  sudo grub-reboot "$SELECTION"
  sleep 2
}

function close_apps() {
  notify-send "power controls" "closing applications"

  HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
  hyprctl --batch "$HYPRCMDS" >>/tmp/power-controls.logs 2>&1

  if pgrep steam >/dev/null; then
    echo "shutting down steam" >>/tmp/power-controls.logs
    steam -shutdown
  fi

  sleep 2

  COUNT=$(hyprctl clients | grep "class:" | wc -l)
  if [ "$COUNT" -eq "0" ]; then
    notify-send "power controls" "closed applications"
  else
    notify-send "power controls" "some apps didn't close, not shutting down"
    exit 1
  fi
}

if [ -z "$1" ]; then
  select_action
else
  ACTION="$1"
fi

case "$ACTION" in
poweroff)
  close_apps
  systemctl poweroff
  ;;
reboot)
  close_apps
  systemctl reboot
  ;;
logout)
  close_apps
  hyprctl dispatch exit
  ;;
grub)
  grub
  close_apps
  systemctl reboot
  ;;
close)
  close_apps
  ;;
*)
  echo "usage: $0 <poweroff | reboot | logout | grub | close>"
  exit 1
  ;;
esac
