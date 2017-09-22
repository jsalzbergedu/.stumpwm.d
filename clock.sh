#!/bin/bash
TIME=$(date "+%T" | awk '{hrmin = substr($0, 0, 5)}; END {print hrmin}')
HOUR=$(date "+%T" | awk '{hrmin = substr($0, 0, 2)}; END {print hrmin}')
MIN=$(date "+%T" | awk '{hrmin = substr($0, 4, 2)}; END {print hrmin}')
# Converting time to the standard of the home of the free:
PMAM=$(echo "$HOUR" | awk 'END {if ($1 > 12) {print "PM"} else {print "AM"}}')
ADJH=$(echo "$HOUR" | awk 'END {if ($1 > 12) {print ($1 - 12)} else {print ($1)}}')
DATE=$(date "+%a %b %d")
CLOCK=$(echo -n "$DATE $ADJH:$MIN $PMAM")
echo "\"$CLOCK\""
