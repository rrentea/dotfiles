window_start=$(xwininfo -id $(xdotool getactivewindow) | grep 'Absolute upper-left X' | cut -f2 -d':')
window_width=$(xwininfo -id $(xdotool getactivewindow) | grep 'Width' | cut -f2 -d':')
window_end=$((window_start + window_width))
screen_end=$(($(xdpyinfo | awk '/dimensions/{print $2}' | cut -f1 -d'x') - 10))
if ((window_end > screen_end));then
   i3-msg resize shrink width 1px or 1 ppt
elif ((window_start < 10));then
   i3-msg resize grow width 1px or 1 ppt
fi
