#!/bin/bash

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
    notify-send "power controls" "some apps didn't close, not shutting down."
    exit 1
  fi
}

case $1 in
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
close)
  close_apps
  ;;
*)
  echo "usage: $0 <shutdown | reboot>"
  exit 1
  ;;
esac
