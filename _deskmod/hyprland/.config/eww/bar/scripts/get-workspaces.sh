#!/bin/bash

spaces () {
	monitor_id="$1"

    if [[ $monitor_id == 0 ]]; then
        sequence="1 6"
    else
        sequence="11 16"
    fi

    focused_monitor=$(hyprctl monitors -j | jq --argjson monitor_id "$monitor_id" '.[] | select(.id == $monitor_id).name')

    workspace_windows=$(hyprctl workspaces -j | jq --argjson focused_monitor "$focused_monitor" 'map(select(.monitor == $focused_monitor) | {key: .id | tostring, value: .windows}) | from_entries')

    seq $sequence | jq --argjson windows "${workspace_windows}" --slurp -Mc 'map(tostring) | map({id: ., windows: ($windows[.]//0)})'
}

spaces $1
socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	spaces $1
done
