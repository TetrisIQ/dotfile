#!/bin/sh
state=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "state:")
percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep "percentage:" | cut -d " " -f15 | sed 's/%//')
if [[ "$state" == *"discharging"* ]]; then
  if [ "$percentage" -lt 10 ]; then
    notify-send 'Akkustand Kritisch!' 'Hey, Jetzt reichts aber mit dem lernen. Geh mal raus und kauf deiner Kathrin Blumen oder so.' -a bat
  fi
fi
