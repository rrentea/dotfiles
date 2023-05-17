#!/bin/bash
 
shutdown=' Shutdown'
reboot=' Reboot'
lock=' Lock'
sleep=' Sleep'
logout='﫻 Logout'
 
selected_option=$(echo "$lock
$logout
$sleep
$reboot
$shutdown" | rofi -dmenu -i -p "Powermenu" \
		  -theme "~/.config/rofi/powermenu.rasi")

if [ "$selected_option" == "$lock" ]
then
    betterlockscreen -l
elif [ "$selected_option" == "$logout" ]
then
    i3-msg exit
elif [ "$selected_option" == "$shutdown" ]
then
    systemctl poweroff
elif [ "$selected_option" == "$reboot" ]
then
    systemctl reboot
elif [ "$selected_option" == "$sleep" ]
then
    mpc -q pause
    amixer set Master mute
    systemctl suspend
else
    echo "No match"
fi
