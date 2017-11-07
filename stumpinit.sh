#!/usr/bin/bash
pushd /home/jacob/.stumpwm.d/ > /dev/null
/usr/bin/compton -b  --config ./compton.conf --xrender-sync --xrender-sync-fence --vsync none
/usr/bin/xrdb -merge ./.Xresources
/usr/bin/urxvtd --quiet --opendisplay --fork
# /usr/bin/bash ./lemonbar.sh | lemonbar -dp -f "FiraMono" -f 'WifiStatus2' & disown
/usr/bin/bash "$HOME/.stumpwm.d/lemoneval.sh" &
# # This is a hack that assumes the first window is stumpwm's messages. Be careful!
# MESSAGE_WINDOW=$(xwininfo -root -children | grep -m 3 "(has no name)" | tail -n 1 | sed "s/(has no name).\+//" | sed "s/\s\+//")
# compton-trans -w $MESSAGE_WINDOW -o 90
# /home/jacob/.stumpwm.d/day-night-toggle.sh "INIT" & disown
/home/jacob/.stumpwm.d/day-night-toggle & disown
/usr/bin/emacs --daemon
setxkbmap -option "caps:swapescape"
offlineimap & disown
