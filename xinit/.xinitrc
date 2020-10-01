while true; do
    slstatus
    sleep 1s
done &

~/.fehbg

[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

exec dwm
