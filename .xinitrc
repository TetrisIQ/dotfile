rand=$(awk -v min=1 -v max=3 'BEGIN{srand(); print int(min+rand()*(max-min+1))}');
export BAR=$rand
xsetroot -cursor_name left_ptr &
pulseaudio --start
insync-headless start &
sxhkd &
nm-applet --sm-disable &
date >> bspwm.log
exec bspwm >> bspwm.log
