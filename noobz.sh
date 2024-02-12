#!/bin/sh

apt install git
git clone https://github.com/noobz-id/noobzvpns.git
cd noobzvpns/
./install.sh
systemctl enable noobzvpns
systemctl start noobzvpns
systemctl restart noobzvpns
journalctl -u noobzvpns
systemctl status noobzvpns
