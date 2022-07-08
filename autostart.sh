#!/bin/env sh

#set resolution and refresh rate
if [ -x "$(command -v xrandr)" ]; then
  xrandr -s 2560x1080 -r 100
fi

#boot picom if it exists
if [ -x "$(command -v picom)" ]; then
  picom &
fi

#set background
if [ -x "$(command -v nitrogen)" ]; then
  nitrogen --restore &
fi

#start polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#start notification daemon
if [ -x "$(command -v dunst)" ]; then
  dunst &
fi

# sxhkd
if [ -x "$(command -v sxhkd)" ]; then
  sxhkd &
fi

#set redshift for night light
# if [ -x "$(command -v redshift)" ]; then
#   redshift-gtk &
# fi

# file manager
if [ -x "$(command -v nautilus)" ]; then
  nautilus --gapplication-service &
fi

if [ -x "$(command -v emacs)" ]; then
  systemctl --user start emacs
fi

if [ -x "$(command -v easyeffects)" ]; then
  systemctl --user start easyeffects
fi

# Make sure to synchronize time
# timedatectl set-ntp true
