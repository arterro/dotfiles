#!/bin/bash

entries="Logout\nSuspend\nReboot\nShutdown"

selected=$(echo -e $entries | wofi --show=dmenu --conf=$XDG_CONFIG_HOME/wofi/config.power --style=$XDG_CONFIG_HOME/wofi/style.power.css | awk '{print tolower($1)}')

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac

