#!/bin/bash
if [ "($whoami)" != "root"];
then
  echo "Root reqired"
else
  bspc config pointer_follows_focus false
  xrandr --output VIRTUAL2 --off --output HDMI1 --off --output VIRTUAL1 --off --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
  sudo xrandr --fb 3840x1080 --output eDP1
  bspc monitor VIRTUAL1 -r
fi
