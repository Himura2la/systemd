#!/bin/bash
set -e
hash curl || exit 1

script_path="/opt/porkbun-ssl"
systemd_path="/etc/systemd/system"
remote_path="https://github.com/Himura2la/systemd/raw/master/porkbun-ssl"

set -x
mkdir -p "$script_path"

curl -LSs "$remote_path/retrieve.sh" --output "$script_path/retrieve.sh"
chmod +x "$script_path/retrieve.sh"

[ ! -f "$script_path/.env" ] && \
    curl -LSs "$remote_path/.env" --output "$script_path/.env"

curl -LSs "$remote_path/porkbun-ssl-retrieve.service" --output "$systemd_path/porkbun-ssl-retrieve.service"
curl -LSs "$remote_path/porkbun-ssl-retrieve.timer" --output "$systemd_path/porkbun-ssl-retrieve.timer"

systemctl daemon-reload
set +x

echo "
TODO:
    vim $script_path/.env
    $script_path/retrieve.sh
    service porkbun-ssl-retrieve start
    service porkbun-ssl-retrieve status
    systemctl enable porkbun-ssl-retrieve.timer
"
