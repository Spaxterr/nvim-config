#!/usr/bin/env bash
# Set the wallpaper for hyprpaper + hyprlock: set-wallpaper.sh <image>, or no argument to pick one with rofi.
# Both configs read ~/.config/hypr/wallpaper, a symlink this script points at your image.
set -euo pipefail
dir=~/Pictures/wallpapers

img=${1:-}
if [[ -z $img ]]; then
  name=$(find "$dir" -maxdepth 1 -type f \( -iname '*.png' -o -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.webp' \) -printf '%f\n' | sort | rofi -dmenu -i -p wallpaper)
  img=$dir/$name
fi
img=$(realpath "$img")
[[ -f $img ]] || { echo "not a file: $img" >&2; exit 1; }

ln -sfn "$img" ~/.config/hypr/wallpaper
hyprctl hyprpaper wallpaper ",$img,cover" >/dev/null
