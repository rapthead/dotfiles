#!/usr/bin/env bash

# Terminate already running bar instances
pkill polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar.log
polybar bar >>/tmp/polybar.log 2>&1 &

echo "Bars launched..."
