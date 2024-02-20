#!/bin/bash

# / Rerechan02 Install NoobZVPN'S
# / Free Open Source
# / It is prohibited to sell this script 
# / @fn_project | @ Rerechan02 | @PR_Aiman

# [ Create Directory File ]
mkdir -p /etc/noobzvpns

# [ Membuat Json Config yang di gunakan pada server ]
cat > /etc/noobzvpns/config.json <<-JSON
{
	"tcp_std": [
		8080
	],
	"tcp_ssl": [
		8443
	],
	"ssl_cert": "/etc/xray/xray.crt",
	"ssl_key": "/etc/xray/xray.key",
	"ssl_version": "AUTO",
	"conn_timeout": 60,
	"dns_resolver": "/etc/resolv.conf",
	"http_ok": "HTTP/1.1 101 Switching Protocols[crlf]Upgrade: websocket[crlf]"
}
JSON
# Port Dari tcp_std & tcp_ssl edit sesuai kemauan kalian agar tidak bentrok dengan service lain pada vps kalian


# [ wget ambil file ]
wget -O /usr/bin/noobzvpns "https://github.com/noobz-id/noobzvpns/raw/master/noobzvpns.x86_64"

# [ Memberi Izin Exec pada file biner ]
chmod +x /usr/bin/noobzvpns

# [ Mengambil Service yang di perlukan ]
wget -O /etc/systemd/system/noobzvpns.service "https://github.com/noobz-id/noobzvpns/raw/master/noobzvpns.service"

# [ Enable & Start Service ]
systemctl enable noobzvpns
systemctl restart noobzvpns

clear
echo " Done Install "
sleep 2
clear