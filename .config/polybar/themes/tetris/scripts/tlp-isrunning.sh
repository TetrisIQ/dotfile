#!/bin/bash

status=$(systemctl status tlp | grep Active: | cut -d " " -f5)

if [ "$status" == "inactive" ]; then 
	echo "TLP: %{F#e50d0d}%{F-}"
fi
