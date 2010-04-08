#!/bin/sh
LOGFILE="$HOME/.xserver.log"
LANG="en_US.UTF-8"; export LANG
numlockx &
setxkbmap -model pc105 -layout fr
urxvtd -q -o -f >> $LOGFILE 2>>$LOGFILE &
hsetroot -fill $HOME/photos/wallpaper.png &
while true
do
	python ~/config/dwm/imap.py
	sleep 10m
done &
exec dwm >>$LOGFILE 2>>$LOGFILE
