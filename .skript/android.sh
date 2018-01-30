#!/bin/sh
if [ "$(whoami)"  !=  "root" ];
then
    echo "Root reqired"
else
    sudo xrandr --fb 3840x1080 --output eDP1 --panning 1920x1080+0+0/3840x1080+0+0
    xrandr --addmode VIRTUAL1 1920x1080
    xrandr --output VIRTUAL1 --off --output HDMI1 --off --output VIRTUAL1 --mode 1920x1080 --pos 1920x0 --rotate normal --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    bspc monitor VIRTUAL1 -d 8 9 0
    polybar -c /home/alex/.config/polybar/themes/dark-red/polybar top2 -q > /dev/null &
    bspc config pointer_follows_focus true
	sudo x11vnc -clip 1920x1080+1920+0 -nocursorshape -passwd Protokollraum15 &
# dann polybar und so
fi
