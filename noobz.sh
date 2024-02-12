#!/bin/sh

apt install git
git clone https://github.com/noobz-id/noobzvpns.git
cd noobzvpns/
./install.sh
systemctl start noobzvpns.service
systemctl restart noobzvpns.service
systemctl enable noobzvpns.service
systemctl status noobzvpns.service -l
journalctl -u noobzvpns.service
