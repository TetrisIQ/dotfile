#!/bin/bash
pactl set-sink-volume 0 +5%

Vol=$(amixer -c 0 get Master | grep Mono: | cut -d " " -f6 |  sed 's/[][]//g')
int=$(amixer -c 0 get Master | grep Mono: | cut -d " " -f6 |  sed 's/[][]//g' | rev | cut -c 2- | rev)

if [[ "$int" == "0" ]]
then 
	notify-send ' Mute'
	
if [[ "$int" -gt 50]]
then 
	notify-send ' $Vol'
	
else
notify-send ' $Vol'