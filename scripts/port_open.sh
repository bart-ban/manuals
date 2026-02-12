#!/usr/bin/env bash

# Configuration
START_PORT=8001
END_PORT=8005
LOGFILE="port_test.log"

echo "Starting TCP and UDP test listeners from $START_PORT to $END_PORT"
echo "Logging to $LOGFILE"
echo "Press Ctrl+C to stop."

# Clean old log
: > "$LOGFILE"

PIDS=()

start_tcp() {
    local port=$1
    socat TCP-LISTEN:$port,reuseaddr,fork SYSTEM:"echo TCP port $port open; echo [TCP:$port] connection from \$SOCAT_PEERADDR >> $LOGFILE" &
    PIDS+=($!)
}

start_udp() {
    local port=$1
    socat UDP-LISTEN:$port,reuseaddr,fork SYSTEM:"echo UDP port $port open; echo [UDP:$port] packet from \$SOCAT_PEERADDR >> $LOGFILE" &
    PIDS+=($!)
}

# Start listeners
for ((p=START_PORT; p<=END_PORT; p++)); do
    start_tcp $p
    start_udp $p
done

# Cleanup function
cleanup() {
    echo
    echo "Stopping listeners..."
    for pid in "${PIDS[@]}"; do
        kill "$pid" 2>/dev/null
    done
    echo "Done."
    exit 0
}

trap cleanup INT TERM

# Keep script alive
while true; do
    sleep 1
done
