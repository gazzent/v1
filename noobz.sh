#!/bin/sh

apt install git
git clone https://github.com/noobz-id/noobzvpns.git
cd noobzvpns/
./install.sh

systemctl enable noobzvpns.service
systemctl start noobzvpns.service
systemctl restart noobzvpns.service
