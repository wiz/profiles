#!/bin/sh

# gnome-terminal java repainting bug
export _JAVA_AWT_WM_NONREPARENTING=1
# set locale
export LANG=ja_JP.UTF-8
mozc_server_start
export XMODIFIERS=@im=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
ibus-daemon --daemonize --xim
sleep 1
export XIM=ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=xim
export XMODIFIERS=@im=ibus
export XIM_PROGRAM="ibus-daemon"
export XIM_ARGS="--daemonize --xim"

xscreensaver -no-splash &

#xrandr --screen 1 -o right
#xrandr --screen 2 -o left

setxkbmap jp
setxkbmap -option ctrl:nocaps

xbindkeys_autostart

exec ck-launch-session dbus-launch awesome 2>&1 > $HOME/.xsession-errors
