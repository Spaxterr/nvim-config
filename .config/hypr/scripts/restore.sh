#!/bin/sh
# Pick a minimized window (on special:minimized) and bring it back to the current workspace
sel=$(hyprctl clients -j | jq -j '.[] | select(.workspace.name=="special:minimized")
  | "\(.address)\t\(.class)  ·  \(.title)\u0000icon\u001f\(.class | ascii_downcase)\n"' \
  | rofi -dmenu -i -p restore -display-columns 2 -display-column-separator '\t')
[ -n "$sel" ] || exit 0

addr=$(printf '%s' "$sel" | cut -f1)
ws=$(hyprctl activeworkspace -j | jq -r .id)
hyprctl dispatch "hl.dsp.window.move({ workspace = \"$ws\", window = \"address:$addr\" })" >/dev/null
hyprctl dispatch "hl.dsp.focus({ window = \"address:$addr\" })" >/dev/null
