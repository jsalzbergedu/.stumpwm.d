NETWORK=$(iw "$1" link | grep 'SSID' | sed 's/SSID: //' | sed 's/\t//')
echo "\"$NETWORK\""
