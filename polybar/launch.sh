#!/usr/bin/env bash

polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar1.log
polybar i3>&1 | tee -a /tmp/polybar1.log & disown

echo "Bars launched..."
