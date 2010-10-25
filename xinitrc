#!/bin/sh
LOGFILE="$HOME/.xserver.log"
#LANG="en_US.UTF-8"; export LANG
#numlockx &
#setxkbmap -model pc105 -layout fr
#xrandr --output LVDS --mode 1280x800
urxvtd -q -o -f &
#hsetroot -fill $HOME/photos/wallpaper.png &
eval $(ssh-agent)
exec wmfs 
#exec "wmfs 2>&1 | tee -a $LOGFILE"
