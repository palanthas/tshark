#!/bin/bash

mkdir -p "$HOME/Desktop/tmp"
PIDFILE="$HOME/Desktop/tmp/tshark.pid"

# Check if tshark is already running. If not, start tshark
if [ -e "${PIDFILE}" ] && (ps -u $(whoami) -opid= |
                           grep -P "^\s*$(cat ${PIDFILE})$" &> /dev/null); then
  echo "Already running."
  exit 99
fi

# Run tshark in ring buffer mode. Creates 24 files in 1 hour increments. After 24 files it will start writing over the oldest files to keep a roll 24 hour log of netowrk activity.
tshark -i eth0 -b duration:3600 -b files:24 -w $HOME/Desktop/tshark.pcap &

echo $! > "${PIDFILE}"
chmod 644 "${PIDFILE}"