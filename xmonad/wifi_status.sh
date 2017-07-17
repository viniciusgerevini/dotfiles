#!/bin/sh
ssid=`nmcli -t -f ssid,in-use dev wifi | grep '\:\*' | cut -d ':' -f1`
signal=`nmcli -t -f signal,in-use dev wifi | grep '\:\*' | cut -d ':' -f1`

echo "$signal% ($ssid)"

exit 0
