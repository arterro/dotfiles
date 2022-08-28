#!/bin/sh

swayidle -dw \
    timeout 100 'pgrep swaylock || swaylock' \
    timeout 120 'brightnessctl set  85%-' \
        resume 'brightnessctl set +85%' \
    timeout 130 'swaymsg "output * dpms off"' \
            resume 'swaymsg "output * dpms on"' \
            after-resume 'swaymsg "output * enable"'
    #timeout 300 'swaymsg "output * dpms on"; sleep 1; swaymsg "output * enable"; sleep 1; systemctl suspend' \
    #timeout 300 'systemctl suspend' \
    #before-sleep 'pgrep swaylock || swaylock'
