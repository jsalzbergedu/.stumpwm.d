#!/usr/bin/bash

# Welcome message:
echo "%{c}%{F#899BA6}%{B#C03C4C55} Welcome! %{F-}%{B-}"
sleep 2

# Define the clock
function Emacs {
    STATUS=$(emacsclient -e '(identity t)' > /dev/null 2>&1; echo $?)
    if [ "$STATUS" = "0" ]
    then
	Icon "EMACS"
    else
	echo "$(Icon 'EMACS')!"
    fi
}

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
    EMACS="\u0511"
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
	"EMACS")
	    echo -e "$EMACS"
	    ;;
	*)
	    echo -n "Icon Not Found"
	    ;;
    esac
}

function WifiStr {
    if [ "$(iw wlp4s0 link > /dev/null 2>&1; echo $?)" = "0" ]
    then
	echo "$(iw wlp4s0 link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')"
    elif [ "$(iw wlan0 link > /dev/null 2>&1; echo $?)" = "0" ]
    then
	echo "$(iw wlan0 link | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')"
    else
	echo "0"
    fi
}

function Wifi {
    STR="$(WifiStr)"
    if [ "x$NETWORK" = "x" ]
    then
	STRICON=""
    else
	if [ "x$STR" = "x" ]
	then
	    STRICON=""
	else
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
	fi
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
        echo "%{c}%{F#899BA6}%{B#C03C4C55} $(Clock) $(Wifi) %{A:emacs --daemon:}$(Emacs)%{A} %{A:systemctl poweroff:}$(Icon POWER_OFF) %{A}%{F-}%{B-}"
        sleep 1
done
