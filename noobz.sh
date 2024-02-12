#!/bin/sh

apt install git
git clone https://github.com/noobz-id/noobzvpns.git
cd noobzvpns/
./install.sh
systemctl start noobzvpns
systemctl restart noobzvpns
systemctl enable noobzvpns
journalctl -u noobzvpns
