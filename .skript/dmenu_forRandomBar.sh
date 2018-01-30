#!/bin/sh

# -sb is linecolor from polybar
case $(printenv BAR) in
  1)
    # red
    dmenu_run -nb '#222' -nf '#eee' -sb '#7B0000' -b -fn monospace
    ;;
  2)
    # yellow
    dmenu_run -nb '#222' -nf '#eee' -sb '#704B0F' -b -fn monospace
    ;;
  3)
    # green
    dmenu_run -nb '#222' -nf '#eee' -sb '#115A06' -b -fn monospace
    ;;
  4)
  dmenu_run -nb '#222' -nf '#eee' -sb '#e57500' -b -fn monospace
    ;;
  5)
    dmenu_run -nb '#222' -nf '#eee' -sb '#917fff' -b -fn monospace
    ;;
esac
