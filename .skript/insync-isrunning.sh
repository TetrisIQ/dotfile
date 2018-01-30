#!/bin/sh

case "$1" in
    --toggle)
        if [ "$(pgrep insync)" ]; then
            pkill -f dropbox
        else
            insync-headless start
        fi
        ;;
    *)
        if [ "$(pgrep insync)" ]; then
            echo " "
        else
            echo "X "
        fi
        ;;
esac
