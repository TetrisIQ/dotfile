xsetroot -cursor_name left_ptr &
pulseaudio --start
insync-headless start &
sxhkd &
nm-applet --sm-disable &
date >> bspwm.log
exec bspwm >> bspwm.log
