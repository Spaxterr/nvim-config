#!/bin/sh
# Usage: screenshot.sh [region|window|screen]
# Saves to ~/Pictures/Screenshots, copies to clipboard, and notifies with an "Annotate" button (satty).
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$1" in
  window) grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$file" ;;
  screen) grim -o "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')" "$file" ;;
  *)      geo=$(slurp -d -b 30344680 -c ca9ee6ff -w 2) || exit 0   # Esc cancels
          grim -g "$geo" "$file" ;;
esac || exit 1

wl-copy < "$file"

if command -v satty >/dev/null; then
  action=$(notify-send -a Screenshot -i "$file" -A annotate=Annotate "Screenshot saved" "$(basename "$file") · copied to clipboard")
  [ "$action" = annotate ] && satty --filename "$file" --output-filename "$file"
else
  notify-send -a Screenshot -i "$file" "Screenshot saved" "$(basename "$file") · copied to clipboard"
fi
