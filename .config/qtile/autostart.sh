#!/bin/sh

# Slstatus
slstatus &

# Wallpapers
feh --bg-fill ~/.config/wallpapers/nord.png

# Compositor
picom --config ~/.config/picom/picom.conf -b

# Screenshots 
flameshot &

# Start notifications manager
dunst &
notify-send -a Notification -u low "Hi !" -i "~/.config/dunst/icons/welcome.svg"

# Start redshift
redshift &

# Load mpd playlist
mpc load Music
mpc play
mpc pause

# Start telegram
# telegram-desktop -startintray & 

# Start kde-connect
/usr/lib/kdeconnectd &
/usr/bin/kdeconnect-indicator &

# Start nextcloud
# nextcloud &

# Start trilium
# start_trilium &
blueman-applet &
