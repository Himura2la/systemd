Currently I have startup scripts for the following things:

- [TeamSpeak 3 Server](ts3.service)
- [ZeroNet network server](zeronet.service)
- [TTL fix for free Y\*\*a Internet Tethering](ttl-fix.service). (`wget goo.gl/sq3F7L`)

# Useful commands

```bash
sudo useradd --home-dir /home/zeronet --create-home --system --shell /usr/sbin/nologin --user-group -G debian-tor zeronet

echo "[global]
ui_ip = *
ui_password = anypassword
" > /etc/zeronet.conf
chmod 600 /etc/zeronet.conf
sudo chown zeronet:zeronet /etc/zeronet.conf

cp zeronet.service /etc/systemd/system/zeronet.service
chmod 644 /etc/systemd/system/zeronet.service
sudo chown root:root /etc/systemd/system/zeronet.service

sudo systemctl daemon-reload
sudo systemctl enable zeronet.service
sudo service zeronet start
sudo service zeronet status
```

Thanks to these articles:
- [Systemd за пять минут](https://habrahabr.ru/company/centosadmin/blog/255845/)
- [Toxcore Bootstrap Daemon Instructions](https://github.com/irungentoo/toxcore/tree/master/other/bootstrap_daemon)
