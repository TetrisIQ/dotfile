#!/bin/bash
pactl set-sink-volume 0 -5%

Vol=$(amixer -c 0 get Master | grep Mono: | cut -d " " -f6 |  sed 's/[][]//g')
int=$(amixer -c 0 get Master | grep Mono: | cut -d " " -f6 |  sed 's/[][]//g' | rev | cut -c 2- | rev)

notify-send ' ' $Vol