#!/bin/sh
case $(printenv BAR) in
  1)
  #create bar in red
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#7B0000"    #linecolor from polybar
    dunst -config ~/.config/polybar/themes/dark-red/dunst &
    polybar -c ~/.config/polybar/themes/dark-red/polybar top -q &
    polybar -c ~/.config/polybar/themes/dark-red/polybar bottom -q &
    ;;
  2)
  #create bar in yellow
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#704B0F"      #linecolor from polybar
    dunst -config ~/.config/polybar/themes/darkpx/dunst &
    polybar -c ~/.config/polybar/themes/darkpx/polybar top -q &
    polybar -c ~/.config/polybar/themes/darkpx/polybar bottom -q &
    ;;

  3)
  #create bar in green
  bspc config normal_border_color "#333333"
  bspc config focused_border_color "#115A06"       #linecolor from polybar
  dunst -config ~/.config/polybar/themes/dark-green/dunst &
  polybar -c ~/.config/polybar/themes/dark-green/polybar top -q &
  polybar -c ~/.config/polybar/themes/dark-green/polybar bottom -q &
  ;;

  4)
  #create bar in orange
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#e57500"      #linecolor from polybar
    dunst -config ~/.config/polybar/themes/dark-orange/dunst &
    polybar -c ~/.config/polybar/themes/dark-orange/polybar top -q &
    polybar -c ~/.config/polybar/themes/dark-orange/polybar bottom -q &
    ;;

  5)
  #create bar in light blue
    bspc config normal_border_color "#333333"
    bspc config focused_border_color "#917fff"      #linecolor from polybar
    dunst -config ~/.config/polybar/themes/dark-lightblue/dunst &
    polybar -c ~/.config/polybar/themes/dark-lightblue/polybar top -q &
    polybar -c ~/.config/polybar/themes/dark-lightblue/polybar bottom -q &
    ;;


esac
