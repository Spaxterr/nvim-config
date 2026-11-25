#!/bin/sh
# Usage: screenshot.sh [region|window|screen]
# Always copies the raw shot to the clipboard, then opens it in satty to draw on it.
# Enter = copy the annotated version + save to ~/Pictures/Screenshots, Esc = close (raw shot stays on the clipboard).
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"

case "$1" in
  window) set -- -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" ;;
  screen) set -- -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" ;;
  *)      geo=$(slurp -d -b 232634cc -w 0) || exit 0  # Esc cancels
          set -- -g "$geo" ;;
esac

tmp=$(mktemp --suffix=.png)
trap 'rm -f "$tmp"' EXIT
grim "$@" "$tmp" || exit 1
wl-copy -t image/png < "$tmp"

satty --filename "$tmp" \
  --output-filename "$dir/%Y-%m-%d_%H-%M-%S.png" \
  --copy-command wl-copy \
  --initial-tool arrow \
  --actions-on-enter save-to-clipboard,save-to-file,exit \
  --actions-on-escape exit
