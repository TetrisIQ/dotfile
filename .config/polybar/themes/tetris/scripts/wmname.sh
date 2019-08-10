#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(wmname)" != "BSPWM" ]; then
            wmname BSPWM
        else
            wmname LG3D 
        fi
        ;;
    *)
        if [ "$(wmname)" != "BSPWM" ]; then
        # echo LG3D
        	echo "X $(wmname)"
        else
        # echo bswpwm
        	echo "X $(wmname) "
        fi
        ;;
esac
