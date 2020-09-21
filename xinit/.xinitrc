while true; do
    slstatus
    sleep 1s
done &

~/.fehbg &

setxkbmap -option caps:swapescape

exec dwm
