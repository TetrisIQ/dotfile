#!/bin/sh
#------------------------------------------#
#       Install script for my dotfiles     #
#               by TetrisIQ                #
#------------------------------------------#

# check if the bspwm config folder exists, and create it if not
if [ ! -d ~/.config/bspwm ]; then
  mkdir ~/.config/bspwm
  toutch ~/.config/bspwm/bspwmrc
fi
# check if the sxhkd config folder exists, and create it if not
if [ ! -d ~/.config/sxhkd ]; then
  mkdir ~/.config/sxhkd
  toutch ~/.config/sxhkd/sxhkdrc
fi
# check if the polybar themes folder exists, and create it if not
if [ ! -d ~/.config/polybar/themes ]; then
  mkdir ~/.config/polybar/themes
fi
# check if the skript folder exists, and create it if not
if [ ! -d ~/.skript ]; then
  mkdir ~/.skript
fi
# backup the old bspwmrc file and replace it with the new one
mv ~/.config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc.bakup
cp .config/bspwm/bspwmrc ~/.config/bspwm/bspwmrc
# backup the old sxhkd file and replace it with the new one
mv ~/.config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc.backup
cp .config/sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
# move my polybar themes in the themes folder
cp .config/polybar/themes/ColorFull -r ~/.config/polybar/themes
# move my scripts in the script folder
cp .skript/* ~/.skript
