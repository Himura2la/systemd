#!/bin/bash
wallpapers_dir="${1?"Usage: $0 <wallpapers_dir>"}"
wallpapers_glob="${wallpapers_dir%/}/*"
random_wallpaper=$(shuf -n1 -e $wallpapers_glob)
gsettings set org.gnome.desktop.background picture-uri "file://$random_wallpaper"
gsettings set org.gnome.desktop.background picture-uri-dark "file://$random_wallpaper"
