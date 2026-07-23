#!/usr/bin/env bash

polybar-msg cmd quit

# Wait until any lingering bar processes have actually shut down
while pgrep -u "$UID" -x polybar >/dev/null; do sleep 1; done

echo "---" | tee -a /tmp/polybar1.log

for m in $(polybar --list-monitors | cut -d: -f1); do
  MONITOR=$m polybar i3 >>/tmp/polybar1.log 2>&1 & disown
done

echo "Bars launched on: $(polybar --list-monitors | cut -d: -f1 | tr '\n' ' ')"
