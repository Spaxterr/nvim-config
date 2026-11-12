#!/bin/sh
# One-row icon menu; -format i returns the picked row, so the labels can change freely
theme='window { width: 640px; } inputbar { enabled: false; } listview { columns: 4; lines: 1; }
element { padding: 18px 0; } element-text { horizontal-align: 0.5; }'

case $(printf '󰌾  Lock\n󰍃  Logout\n󰜉  Reboot\n󰐥  Shutdown' | rofi -dmenu -i -format i -p Power -theme-str "$theme") in
  0) loginctl lock-session ;;
  1) hyprctl dispatch 'hl.dsp.exit()' ;;
  2) systemctl reboot ;;
  3) systemctl poweroff ;;
esac
