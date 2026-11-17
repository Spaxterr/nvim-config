#!/bin/sh
# Usage: screenshot.sh [region|window|screen]
# Opens the shot in satty to draw on it. Enter = copy to clipboard + save to ~/Pictures/Screenshots, Esc = discard.
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"

case "$1" in
  window) set -- -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" ;;
  screen) set -- -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" ;;
  *)      geo=$(slurp -d -b 30344680 -c ca9ee6ff -w 2) || exit 0  # Esc cancels
          set -- -g "$geo" ;;
esac

grim "$@" - | satty --filename - \
  --output-filename "$dir/%Y-%m-%d_%H-%M-%S.png" \
  --copy-command wl-copy \
  --initial-tool arrow \
  --actions-on-enter save-to-clipboard,save-to-file,exit \
  --actions-on-escape exit
