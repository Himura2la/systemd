#!/bin/bash
set -xe
hash curl || exit 1

script_path="/opt/porkbun-ssl"
systemd_path="/etc/systemd/system"

remote_path="https://github.com/Himura2la/systemd/raw/master/porkbun-ssl"

mkdir -p $local_path

curl -Ss "$remote_path/retrieve.sh" "$script_path/retrieve.sh"
curl -Ss "$remote_path/.env" "$script_path/.env"
curl -Ss "$remote_path/porkbun-ssl-retrieve.service" "$systemd_path/porkbun-ssl-retrieve.service"
curl -Ss "$remote_path/porkbun-ssl-retrieve.timer" "$systemd_path/porkbun-ssl-retrieve.timer"

systemctl daemon-reload

echo "
TODO:
    vim $script_path/.env

    service porkbun-ssl-retrieve start
    journalctl -ru porkbun-ssl-retrieve

    systemctl enable porkbun-ssl-retrieve.timer
"