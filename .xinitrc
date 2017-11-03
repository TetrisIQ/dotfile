xsetroot -cursor_name left_ptr &
pulseaudio --start
insync-headless start &
dunst &
sxhkd &
nm-applet --sm-disable &
date >> bspwm.log
exec bspwm >> bspwm.log
