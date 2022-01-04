while true; do
    slstatus
    sleep 1s
done &

~/.fehbg

setxkbmap -option grp:alt_shift_toggle "us,de"

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

exec dwm
