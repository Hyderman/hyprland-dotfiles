#!/bin/sh
swayidle -w \
    timeout 300 "swaylock && hyprctl dispatcher dpms off" \
    timeout 600 "systemctl suspend" \
    after-resume sudo modprobe -r hid_logitech_dj && sudo modprobe hid_logitech_dj 
    
