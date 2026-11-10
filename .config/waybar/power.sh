#!/bin/sh

case $(printf "Lock\nLogout\nReboot\nShutdown" | rofi -dmenu -i -p Power) in
  Lock) loginctl lock-session ;;
  Logout) hyprctl dispatch 'hl.dsp.exit()' ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
