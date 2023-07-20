#!/bin/bash

active_workspace () {
    monitor_id="$1"
    
    focused_monitor=$(hyprctl monitors -j | jq --argjson monitor_id "$monitor_id" '.[] | select(.id == $monitor_id).name')
    
    hyprctl monitors -j | jq --raw-output --argjson focused_monitor $focused_monitor '.[] | select(.name == $focused_monitor).activeWorkspace.id'
}

active_workspace $1
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
    active_workspace $1
done
