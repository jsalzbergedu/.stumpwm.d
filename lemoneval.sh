#!/usr/bin/bash
#/usr/bin/bash ./lemonbar.sh | lemonbar -dp -f "FiraMono-Regular" -f 'WifiStatus2' | while read line; do eval "${line}"; done
csi -s ./lemonbar.scm | lemonbar -dp -g 500x22+710+0 -f "FiraMono-Regular" -f 'WifiStatus2' | while read line; do eval "${line}"; done
