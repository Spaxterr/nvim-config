#!/bin/sh
# Toggle the default mic and show its new state. The synchronous hint makes swaync replace the previous popup instead of stacking.
pactl set-source-mute @DEFAULT_SOURCE@ toggle
if pactl get-source-mute @DEFAULT_SOURCE@ | grep -q yes; then
  notify-send -e -a Microphone -i audio-input-microphone-muted -t 1500 -h string:x-canonical-private-synchronous:mic "Microphone muted"
else
  notify-send -e -a Microphone -i audio-input-microphone -t 1500 -h string:x-canonical-private-synchronous:mic "Microphone on"
fi
