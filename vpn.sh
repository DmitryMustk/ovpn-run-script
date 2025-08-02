#!/bin/bash

CONFIG_NAME="YOUR_CONFIG_NAME_WITHOUT_EXTENSION"

CONFIG="./${CONFIG_NAME}.ovpn"
PID_FILE="/tmp/openvpn-${CONFIG_NAME}.pid"

start() {
  if [ -f "$PID_FILE" ] && sudo kill -0 $(cat "$PID_FILE") 2>/dev/null; then
    echo "OpenVPN is already running with PID $(cat "$PID_FILE")"
    exit 1
  fi

  echo "Starting OpenVPN..."
  sudo openvpn --config "$CONFIG" --daemon --writepid "$PID_FILE"
  echo "OpenVPN started in background."
}

stop() {
  if [ ! -f "$PID_FILE" ]; then
    echo "PID file not found. OpenVPN may not be running."
    exit 1
  fi

  PID=$(cat "$PID_FILE")
  echo "Stopping OpenVPN (PID $PID)..."
  sudo kill "$PID" 2>/dev/null || echo "Failed to kill process (it might already be stopped)"
  sudo rm -f "$PID_FILE"
  echo "OpenVPN stopped."
}

status() {
  if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    if sudo kill -0 "$PID" 2>/dev/null; then
      echo "OpenVPN is running (PID $PID)"
      exit 0
    else
      echo "PID file exists, but the process is not running."
      exit 1
    fi
  else
    echo "OpenVPN is not running."
    exit 1
  fi
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  *)
    echo "Usage: $0 {start|stop|status}"
    exit 1
    ;;
esac

