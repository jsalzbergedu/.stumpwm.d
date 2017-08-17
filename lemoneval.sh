#!/usr/bin/bash
/usr/bin/bash ./lemonbar.sh | lemonbar -dp -f "FiraMono" -f 'WifiStatus2' | while read line; do eval "${line}"; done
