#!/bin/sh

adapter_id=wlxc000000000dc
dumps_dir=/home/himura

trap "airmon-ng stop wlan0mon" INT
cd "$dumps_dir"
airmon-ng start "$adapter_id" && \
airodump-ng --output-format csv -w dump wlan0mon

