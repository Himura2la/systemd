#!/bin/sh
set -x

base_path=https://raw.githubusercontent.com/Himura2la/systemd/refs/heads/master/wallpaper-changer

sudo wget -O /etc/systemd/system/wallpaper-changer.service $base_path/wallpaper-changer.service
sudo wget -O /etc/systemd/system/wallpaper-changer.timer   $base_path/wallpaper-changer.timer
sudo wget -O /opt/set-random-wallpaper.sh                  $base_path/set-random-wallpaper.sh
sudo chmod +x /opt/set-random-wallpaper.sh

echo "Please, set your user and wallpapers dir in '/etc/systemd/system/wallpaper-changer.service'"
echo "after that, do 'sudo systemctl daemon-reload && sudo systemctl enable wallpaper-changer.timer'"