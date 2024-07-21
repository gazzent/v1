#!/bin/bash
MYIP=$(wget -qO- ipinfo.io/ip);

#install
rm -rf cybervpn
apt update && apt upgrade -y
apt install python3 python3-pip -y
apt install sqlite3 -y
wget vpncode.whf.bz/bot2/cybervpn.zip
unzip cybervpn.zip
cd cybervpn
rm var.txt
rm database.db
pip3 install -r requirements.txt
pip install pillow
pip install speedtest-cli
#isi data
azi=$(cat /root/nsdomain)
domain=$(cat /etc/xray/domain)
echo "INSTALL BOT CREATE SSH via TELEGRAM"
read -e -p "[*] Input Your Id Telegram :" admin
read -e -p "[*] Input Your bot Telegram :" token
echo -e ADMIN='"'$admin'"' >> /root/cybervpn/var.txt
echo -e BOT_TOKEN='"'$token'"' >> /root/cybervpn/var.txt
echo -e DOMAIN='"'$domain'"' >> /root/cybervpn/var.txt
echo -e DNS='"'ns.$domain'"' >> /root/cybervpn/var.txt
echo -e PUB='"7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59"' >> /root/cybervpn/var.txt


clear
echo "Done"
echo "Your Data Bot"
echo -e "==============================="
echo "Api Token     : $token"
echo "ID            : $admin"
echo "DOMAIN        : $domain"
echo -e "==============================="
echo "Setting done"

cat > /etc/systemd/system/cybervpn.service << END
[Unit]
Description=Simple CyberVPN - @CyberVPN
After=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/python3 -m cybervpn
Restart=always

[Install]
WantedBy=multi-user.target

END
systemctl daemon-reload
systemctl start cybervpn
systemctl enable cybervpn
clear
echo "downloading asset"

wget -q -O /usr/bin/panelbot "http://bot.kvm-xcode.biz.id/bot/panelbot.sh" && chmod +x /usr/bin/panelbot


wget -q -O /usr/bin/add-vless "http://bot.kvm-xcode.biz.id/bot/add-vless.sh" && chmod +x /usr/bin/add-vless

wget -q -O /usr/bin/addtr "http://bot.kvm-xcode.biz.id/bot/addtr.sh" && chmod +x /usr/bin/addtr


wget -q -O /usr/bin/addws "http://bot.kvm-xcode.biz.id/bot/addws.sh" && chmod +x /usr/bin/addws


wget -q -O /usr/bin/cek-ssh "http://bot.kvm-xcode.biz.id/bot/cek-ssh.sh" && chmod +x /usr/bin/cek-ssh

wget -q -O /usr/bin/cek-tr "http://bot.kvm-xcode.biz.id/bot/cek-tr.sh" && chmod +x /usr/bin/cek-tr

wget -q -O /usr/bin/cek-vless "http://bot.kvm-xcode.biz.id/bot/cek-vless.sh" && chmod +x /usr/bin/cek-vless

wget -q -O /usr/bin/cek-ws "http://bot.kvm-xcode.biz.id/bot/cek-ws.sh" && chmod +x /usr/bin/cek-ws

wget -q -O /usr/bin/del-vless "http://bot.kvm-xcode.biz.id/bot/del-vless.sh" && chmod +x /usr/bin/del-vless


wget -q -O /usr/bin/deltr "http://bot.kvm-xcode.biz.id/bot/deltr.sh" && chmod +x /usr/bin/deltr

wget -q -O /usr/bin/delws "http://bot.kvm-xcode.biz.id/bot/delws.sh" && chmod +x /usr/bin/delws

wget -q -O /usr/bin/renew-ssh "http://bot.kvm-xcode.biz.id/bot/renew-ssh.sh" && chmod +x /usr/bin/renew-ssh


wget -q -O /usr/bin/renewtr "http://bot.kvm-xcode.biz.id/bot/renewtr.sh" && chmod +x /usr/bin/renewtr


wget -q -O /usr/bin/renewvless "http://bot.kvm-xcode.biz.id/bot/renewvless.sh" && chmod +x /usr/bin/renewvless


wget -q -O /usr/bin/renewws "http://bot.kvm-xcode.biz.id/bot/renewws.sh" && chmod +x /usr/bin/renewws

wget -q -O /usr/bin/triall-ssh "http://bot.kvm-xcode.biz.id/bot/triall-ssh.sh" && chmod +x triall-ssh


wget -q -O /usr/bin/trialltr "http://bot.kvm-xcode.biz.id/bot/trialltr.sh" && chmod +x trialltr


wget -q -O /usr/bin/triallws "http://bot.kvm-xcode.biz.id/bot/triallws.sh" && chmod +x triallws



wget -q -O /usr/bin/triallvless "http://bot.kvm-xcode.biz.id/bot/triallvless.sh" && chmod +x triallvless


wget -q -O /usr/bin/cek-mws "http://bot.kvm-xcode.biz.id/bot/cek-mws.sh" && chmod +x /usr/bin/cek-mws

wget -q -O /usr/bin/cek-mvs "http://bot.kvm-xcode.biz.id/bot/cek-mvs.sh" && chmod +x /usr/bin/cek-mvs

wget -q -O /usr/bin/cek-mts "http://bot.kvm-xcode.biz.id/bot/cek-mts.sh" && chmod +x /usr/bin/cek-mts


echo " Installations complete, type /menu on your bot "
rm -rf /root/cybervpn/database.db
rm XolPanel.session
rm  bot.sh
rm cybervpn.zip
