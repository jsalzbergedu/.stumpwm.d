#!/usr/bin/bash

# Welcome message:
echo "%{c}%{F#899BA6}%{B#C03C4C55} Welcome! %{F-}%{B-}"
sleep 2

# Define the clock
function Clock {
    TIME=$(date "+%T" | awk '{hrmin = substr($0, 0, 5)}; END {print hrmin}')
    HOUR=$(date "+%T" | awk '{hrmin = substr($0, 0, 2)}; END {print hrmin}')
    MIN=$(date "+%T" | awk '{hrmin = substr($0, 4, 2)}; END {print hrmin}')
    # Converting time to the standard of the home of the free:
    PMAM=$(echo "$HOUR" | awk 'END {if ($1 > 12) {print "PM"} else {print "AM"}}')
    ADJH=$(echo "$HOUR" | awk 'END {if ($1 > 12) {print ($1 - 12)} else {print ($1)}}')
    DATE=$(date "+%a %b %d")
    echo -n "$DATE $ADJH:$MIN $PMAM"
}

function Icon {
    WIFI_FULL="\ue045"
    WIFI_MID="\ue046"
    WIFI_MIN="\ue048"
    POWER_OFF="\u25ef"
    icon=$1;
    case "$icon" in
	"WIFI_FULL")
	    echo -e "$WIFI_FULL"
	    ;;
	"WIFI_MID")
	    echo -e "$WIFI_MID"
	    ;;
	"WIFI_MIN")
	    echo -e "$WIFI_MIN"
	    ;;
	"POWER_OFF")
	    echo -e "$POWER_OFF"
	    ;;
	*)
	    echo -n "Icon Not Found"
	    ;;
    esac
}

function Wifi {
    NETWORK=$(iw wlp4s0 link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
    STR=$(iw wlp4s0 link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')
    if [ "x$STR" = "x" ]
    then
	NETWORK=$(iw wlan0 link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
	STR=$(iw wlan0 link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')
    fi
    if (($STR >= -55))
    then
	STRICON=$(Icon WIFI_FULL)
    else if (($STR < -55 && $STR >= -75))
	 then
	     STRICON=$(Icon WIFI_MID)
	 else
	     STRICON=$(Icon WIFI_MIN)
	 fi
    fi
    if [ "$NETWORK" = "" ]
    then
	STRICON=""
    fi
    echo -n "$STRICON $NETWORK"
}

function Battery {
    if [ "$(hostname)" = "jacobs-pc" ]
    then
	BATLIST="$(upower -e | grep 'BAT')"
    fi
}

# Print the clock

while true; do
        echo "%{c}%{F#899BA6}%{B#C03C4C55} $(Clock) $(Wifi) %{A:systemctl poweroff:}$(Icon POWER_OFF) %{A}%{F-}%{B-}"
        sleep 1
done
