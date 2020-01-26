setxkbmap "us,ru" ",winkeys" "grp:caps_toggle" -option terminate:ctrl_alt_bksp &
#background='/home/noname/.wallpaper.jpg'
feh --bg-tile ~/background.jpg
#composite -gravity SouthEast /home/noname/.photo.png $background /tmp/Rez.jpg && feh --bg-tile /tmp/Rez.jpg &
#xcompmgr -cCfF -r7 -o.65 -l-10 -t-8 -D7 &
#xrandr --output DVI-0 --primary
numlockx on
tint2 -c ~/.config/tint2/tint2rc &
bin/kuake_toggle &
#pidgin & 
#sleep 1 && sonata --hidden & 
(sleep 5 && conky) & 
#sleep 5 && conky -c $HOME/.config/conky/mpd-conkyrc & 
#sleep 5 && conky -c $HOME/.config/conky/cal-conkyrc & 
#dropbox start &
/home/noname/bin/touchpad_switch &
#sleep 1 && alltray -st -stask urxvt -geometry 110x24 -e ~/bin/rt.sh &
