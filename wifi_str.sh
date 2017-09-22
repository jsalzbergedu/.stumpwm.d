 STR=$(iw "$1" link 2>/dev/null | grep 'signal' | sed 's/signal: //' | sed 's/ dBm//' | sed 's/\t//')
 echo $STR
