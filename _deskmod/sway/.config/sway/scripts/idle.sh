#!/bin/sh

swayidle -dw \
    timeout 150 'pgrep swaylock || swaylock' \
    timeout 100 'brightnessctl set  85%-' \
        resume 'brightnessctl set +85%' \
    timeout 300 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' \
            after-resume 'swaymsg "output * enable"' \
    timeout 1800 'systemctl suspend' \
    before-sleep 'pgrep swaylock || swaylock'
