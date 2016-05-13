#!/bin/bash

mkdir -p "$HOME/Desktop/tmp"
PIDFILE="$HOME/Desktop/tmp/tshark.pid"

if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= |
                           grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  echo "Already running."
  exit 99
fi

#tshark -i eth0 -b duration:3600 -b files:5 -w $HOME/Desktop/2016-05-13.pcap &
tshark -i eth0 -b duration:5 -b files:5 -w $HOME/Desktop/tshark.pcap &

echo $! > "${PIDFILE}"
chmod 644 "${PIDFILE}"
