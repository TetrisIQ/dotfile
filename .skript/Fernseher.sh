#!/bin/sh
bspc monitor HDMI1 -d 8
xrandr --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
polybar -c ~/.config/polybar/themes/darkpx/polybar top2 -q > /dev/null &
