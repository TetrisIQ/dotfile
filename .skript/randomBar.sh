#!/bin/sh
# check if dunst is running, if it is runnung I want to change the the Collor or reload all
if [ $(ps -aux | grep dunst | grep config | cut -b 1) == "a"  ]
then
  killall dunst
  killall polybar

fi
case $(printenv BAR) in
  1)
  #create bar in red
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#7B0000"    #linecolor from polybar
    dunst -config ~/.config/polybar/themes/ColorFull/dunst/dunst-darkRed &
    polybar -c ~/.config/polybar/themes/ColorFull/polybar top-darkRed -q &
    polybar -c ~/.config/polybar/themes/dark-red/polybarBottom bottom-darkRed -q &
    ;;
  2)
  #create bar in yellow
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#704B0F"      #linecolor from polybar
    dunst -config ~/.config/polybar/themes/ColorFull/dunst/dunst-darkPx &
    polybar -c ~/.config/polybar/themes/ColorFull/polybar top-darkPx -q &
    polybar -c ~/.config/polybar/themes/ColorFull/polybarBottom bottom.darkPx -q &
    ;;

  3)
  #create bar in green
  bspc config normal_border_color "#333333"
  bspc config focused_border_color "#115A06"       #linecolor from polybar
  dunst -config ~/.config/polybar/themes/ColorFull/dunst/dunst-green &
  polybar -c ~/.config/polybar/themes/ColorFull/polybar top-green -q &
  polybar -c ~/.config/polybar/themes/ColorFull/polybarBottom bottom-green -q &
  ;;

  4)
  #create bar in orange
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#e57500"      #linecolor from polybar
    dunst -config ~/.config/polybar/themes/ColorFull/dunst/dunst-orange &
    polybar -c ~/.config/polybar/themes/ColorFull/polybar top-orange -q &
    polybar -c ~/.config/polybar/themes/ColorFull/polybarBottom bottom-orange -q &
    ;;

  5)
  #create bar in light blue
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#917fff"      #linecolor from polybar
    dunst -config ~/.config/polybar/themes/ColorFull/dunst/dunst-lightblue &
    polybar -c ~/.config/polybar/themes/ColorFull/polybar top-lightblue -q &
    polybar -c ~/.config/polybar/themes/ColorFull/polybarBottom bottom-lightblue -q &
    ;;


esac
