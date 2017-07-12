function Day {
    for i in {1..20}
    do
	hsetroot -center ~/.stumpwm.d/data/frames/${i}.png
	sleep 0.1
    done
}

function Night {
    for i in {20..1}
    do
	hsetroot -center ~/.stumpwm.d/data/frames/${i}.png
	sleep 0.1
    done
}

MODE="INIT"

while [ 1 -eq 1 ]
      do
	  TIME=$(date "+%H%M")
	  echo "Current time is $TIME"
	  
	  CIVS="$(/usr/local/bin/find-twilight | cut -f1 -d\ )"
	  CIVE="$(/usr/local/bin/find-twilight | cut -f2 -d\ )"
	  echo "Daylight starts at $CIVS ends at $CIVE"
	  echo "Cycle begins with mode as $MODE"
	  if [ $TIME -ge $CIVS ] && [ $TIME -le $CIVE ]
	  then
	      # If this block is called, it is daylight outside.
	      # If it is daylight, outside, but the computer has a dark background, the background must switch:
	      if [ $MODE = "INIT" ] || [ $MODE = "NIGH" ]
	      then
		  MODE="DAYL"
		  echo "Switching to day mode."
		  Day
	      else
		  MODE="DAYL" # If the mode is INIT or DAYL, and the background needs no switch, change it to DAYL
	      fi
	  else
	      # Same as above, but in reverse.
	      if [ $MODE = "INIT" ] || [ $MODE = "DAYL" ]
	      then
		  MODE="NIGH"
		  echo "Switching to night mode."
		  Night
	      else
		  MODE="NIGH"
	      fi
	  fi
	  
	  echo "Cycle complete"
	  echo "Current mode is $MODE"
	  sleep 60
done
