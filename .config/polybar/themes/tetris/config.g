;; Global WM Settings

[global/wm]
; Adjust the _NET_WM_STRUT_PARTIAL top value
; Used for top aligned bars
margin-bottom = 0

; Adjust the _NET_WM_STRUT_PARTIAL bottom value
; Used for bottom aligned bars
margin-top = 0

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; File Inclusion
; include an external file, like module file, etc.

include-file = ~/.config/polybar/themes/tetris/colors
include-file = ~/.config/polybar/themes/tetris/modules
include-file = ~/.config/polybar/themes/tetris/user_modules
include-file = ~/.config/polybar/themes/tetris/decor_modules
include-file = ~/.config/polybar/themes/tetris/bar

;; _-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_

;; Bar Settings

[bar/main]
enable-ipc = true
monitor = ${env:MONITOR:eDP1}
;monitor-fallback = ${env:MONITOR:HDMI1}
width = 100%
height = 24
underline-size = 1
overline-size = 2
border-size = 0
border-color = ${color.trans}
padding-left = 0
padding-right = 0
module-margin-left = 0
module-margin-right = 0

; set colors
background = ${color.trans}
foreground = ${color.fg}
line-color = ${color.trans}

; Fonts
font-0 = Iosevka Nerd Font:style=Medium:size=10;3
font-1 = Font Awesome 5 Free:style=Regular:pixelsize=10;3
font-2 = Iosevka Nerd Font:style=Medium:size=14;3
font-3 = Font Awesome 5 Free:style=Solid:pixelsize=15;3
;backup font for sysmenu TODO: replace icons
font-4 = icomoon\-feather:style=Medium:size=10;3



tray-position = none
wm-restack = bspwm
; Old
;modules-left = power-menu right-end-top left-end-bottom bspwm right-end-top CriticalBatteryState
modules-center = xwindow
;modules-right = left-end-bottom pkg right-end-top left-end-bottom xkeyboard right-end-top left-end-bottom xbacklight right-end-top left-end-bottom alsa right-end-top left-end-bottom battery right-end-top left-end-bottom nerdyDate right-end-top left-end-bottom time

modules-left = power-menu space bspwm right-end-top CriticalBatteryState
;modules-center = right-end-top xwindow left-end-bottom
modules-right = left-end-bottom pkg space github space xkeyboard space xbacklight space pulseaudio space battery space nerdyDate space time

[bar/bottom]
enable-ipc = true
monitor = ${env:MONITOR:eDP1}
width = 100%
background = ${color.trans}
padding-left = 0
padding-right = 0
module-margin-left = 0
module-margin-right = 0
bottom = true
underline-size = 0
overline-size = 0
border-color = ${color.trans}
border-size = 0


; Fonts
font-0 = Iosevka Nerd Font:style=Medium:size=10;3
font-1 = Font Awesome 5 Free:style=Regular:pixelsize=10;3
font-2 = Iosevka Nerd Font:style=Medium:size=14;3
font-3 = Font Awesome 5 Free:style=Solid:pixelsize=15;3
;backup font for sysmenu TODO: replace icons
font-4 = icomoon\-feather:style=Medium:size=10;3

; Old
;modules-left = KW right-end-top left-end-bottom wmname right-end-top tlp xampp mpd
;modules-center = left-end-bottom htop right-end-top left-end-bottom insync right-end-top left-end-bottom oneko right-end-top tap
modules-left = KW space wmname tlp xampp space mpd right-end-top
modules-center = left-end-bottom htop space insync space oneko right-end-top tap


tray-detached = true
tray-position = right
tray-padding = 4
tray-maxsize = 16
