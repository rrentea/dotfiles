#!/bin/sh

restart_ags() {
	pkill agsv1 && agsv1 &
}

handle() {
  case $1 in
    monitoradded*) restart_ags ;;
    monitorremoved*) restart_ags ;;
  esac
}

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
