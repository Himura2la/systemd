Currently I have startup scripts for the following things:

- [TeamSpeak 3 Server](ts3.service)
- [ZeroNet network server](zeronet.service)


# Useful commands

```bash
sudo useradd --home-dir /home/zeronet --create-home --system --shell /usr/sbin/nologin --user-group -G debian-tor zeronet

echo "[global]
ui_ip = *
ui_password = anypassword
" > /etc/zeronet.conf
chmod 600 /etc/zeronet.conf
sudo chown zeronet:zeronet /etc/zeronet.conf

cp ts3.service /etc/systemd/system/ts3.service
chmod 644 /etc/systemd/system/ts3.service
sudo chown root:root /etc/systemd/system/ts3.service

sudo systemctl daemon-reload
sudo systemctl enable ts3.service
sudo service ts3 start
sudo service ts3 status
```

Thanks to these articles:
- [Systemd за пять минут](https://habrahabr.ru/company/centosadmin/blog/255845/)
- [Toxcore Bootstrap Daemon Instructions](https://github.com/irungentoo/toxcore/tree/master/other/bootstrap_daemon)
