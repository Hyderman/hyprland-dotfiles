#!/bin/sh
swayidle -w \
    timeout 300 "swaylock && hyprctl dispatcher dpms off" \
    timeout 600 "systemctl suspend"
