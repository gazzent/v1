#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : Adit Ardiansyah
# (C) Copyright 2022
# =========================================
# // Export Color & Information
hosting=$(curl -sS https://raw.githubusercontent.com/Azigaming404/Autoscript-by-azi/main/domain)
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
mkdir /user/curent > /dev/null 2>&1
touch /user/current
clear
echo "IP=$domain" > /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
# Remove existing binaries and files

echo "Memeriksa sistem operasi"
sleep 0.5

# Detect the operating system
os=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')

# Set package URL based on the detected OS
if [ "$os" == "ubuntu" ]; then
  package_url="https://raw.githubusercontent.com/Azigaming404/Autoscript-by-azi/main/ubuntu.zip"
elif [ "$os" == "debian" ]; then
  package_url="https://cybervpn.serv00.net/Autoscript-by-azi-main/tes/debian.zip"
else
  echo "Unknown operating system. Exiting."
  exit 1
fi

# Download and install the package
cd /usr/local/sbin || exit
wget "$package_url" || { echo "Failed to download package"; exit 1; }
unzip -o "$(basename "$package_url")" || { echo "Failed to unzip package"; exit 1; }
chmod 777 *
cd - || exit

echo "[CHECKING Ntupdate pysc module]"

if [ -e /usr/local/sbin/pysc ]; then
    echo "modul pysc found"
else
    echo "File pysc not found"
    killall -u root
echo -e "[ ${GREEN}INFO${NC} ] Checking... "
sleep 1
echo -e "[ ${GREEN}INFO$NC ] Setting ntpdate"
if [ -e /usr/local/sbin/pysc ]; then
    echo "modul pysc found"
else
    echo "File pysc not found in /usr/local/sbin/"
    killall -u root
fi
sleep 1
domain=$(cat /etc/xray/domain)
apt install iptables iptables-persistent -y
apt install curl socat xz-utils wget apt-transport-https gnupg gnupg2 gnupg1 dnsutils lsb-release -y
apt install socat cron bash-completion ntpdate -y
#ntpdate pool.ntp.org
ntpdate -u pool.ntp.org
apt -y install chrony
timedatectl set-ntp true
#systemctl enable chronyd && systemctl restart chronyd
systemctl enable chrony && systemctl restart chrony
timedatectl set-timezone Asia/Jakarta
#chronyc sourcestats -v
#chronyc tracking -v
apt install curl pwgen openssl netcat cron -y

# Make Folder & Log XRay & Log Trojan
rm -fr /var/log/xray
rm -fr /var/log/trojan
rm -fr /home/vps/public_html
mkdir -p /var/log/xray
mkdir -p /var/log/trojan
mkdir -p /home/vps/public_html
chown www-data.www-data /var/log/xray
chown www-data.www-data /etc/xray
chmod +x /var/log/xray
chmod +x /var/log/trojan
touch /var/log/xray/access.log
touch /var/log/xray/error.log
touch /var/log/xray/access2.log
touch /var/log/xray/error2.log
# Make Log Autokill & Log Autoreboot
rm -fr /root/log-limit.txt
rm -fr /root/log-reboot.txt
touch /root/log-limit.txt
touch /root/log-reboot.txt
touch /home/limit
echo "" > /root/log-limit.txt
echo "" > /root/log-reboot.txt

# Install Wondershaper
cd /root/
apt install wondershaper -y
git clone https://github.com/magnific0/wondershaper.git >/dev/null 2>&1
cd wondershaper
make install
cd
rm -fr /root/wondershaper
echo > /home/limit

# nginx for debian & ubuntu
install_ssl(){
    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            else
                    apt-get install -y nginx certbot
                    apt install -y nginx certbot
                    sleep 3s
            fi
    else
        yum install -y nginx certbot
        sleep 3s
    fi

    systemctl stop nginx.service

    if [ -f "/usr/bin/apt-get" ];then
            isDebian=`cat /etc/issue|grep Debian`
            if [ "$isDebian" != "" ];then
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            else
                    echo "A" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
                    sleep 3s
            fi
    else
        echo "Y" | certbot certonly --renew-by-default --register-unsafely-without-email --standalone -d $domain
        sleep 3s
    fi

}

# install nginx
mkdir -p /home/vps/public_html
wget -q -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/Agunxzzz/XrayCol/main/vps.conf.txt"
sleep 1
wget -q -O xraymode.sh https://$hosting/Autoscript-by-azi-main/xraymode.sh && chmod +x xraymode.sh && ./xraymode.sh
sleep 1 
wget -q -O /etc/xray/config.json "https://$hosting/Autoscript-by-azi-main/configuration/config.json"
chmod +x /etc/xray/config.json
sleep 1 
rm -f /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf "https://$hosting/Autoscript-by-azi-main/configuration/xray.conf"
chmod +x /etc/nginx/conf.d/xray.conf

# Installing Xray Service
rm -fr /etc/systemd/system/xray.service.d
rm -fr /etc/systemd/system/xray.service
cat <<EOF> /etc/systemd/system/xray.service
Description=Xray Service
Documentation=https://github.com/xtls
After=network.target nss-lookup.target

[Service]
User=www-data
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE                            
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/local/bin/xray run -config /etc/xray/config.json
Restart=on-failure
RestartPreventExitStatus=23
LimitNPROC=10000
LimitNOFILE=1000000

[Install]
WantedBy=multi-user.target
EOF

echo -e "[ ${GREEN}ok${NC} ] Enable & Start & Restart & Xray"
systemctl daemon-reload >/dev/null 2>&1
systemctl enable xray >/dev/null 2>&1
systemctl start xray >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1
echo -e "[ ${GREEN}ok${NC} ] Enable & Start & Restart & Nginx"
systemctl daemon-reload >/dev/null 2>&1
systemctl enable nginx >/dev/null 2>&1
systemctl start nginx >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1
# Restart All Service
echo -e "$yell[SERVICE]$NC Restart All Service"
sleep 1
chown -R www-data:www-data /home/vps/public_html
# Enable & Restart & Xray & Trojan & Nginx
sleep 1
echo -e "[ ${GREEN}ok${NC} ] Restart & Xray & Nginx"
pysc >/dev/null 2>&1
systemctl daemon-reload >/dev/null 2>&1
systemctl restart xray >/dev/null 2>&1
systemctl restart nginx >/dev/null 2>&1

#LIMIT QUOTA
wget -q -O /usr/local/sbin/quota "http://cybervpn.serv00.net/Autoscript-by-azi-main/limit/quota.sh"
chmod +x /usr/local/sbin/quota
chmod +x /usr/local/sbin/quota
cd /usr/local/sbin/
sed -i 's/\r//' quota 



#SERVICE QUOTA VMESS
cat >/etc/systemd/system/qmv.service << EOF
[Unit]
Description=My
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota vmess
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmv
systemctl enable qmv

#SERVICE QUOTAVLESS
cat >/etc/systemd/system/qmvl.service << EOF
[Unit]
Description=My 
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota vless
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmvl
systemctl enable qmvl

#SERVICE TROJAN
cat >/etc/systemd/system/qmtr.service << EOF
[Unit]
Description=My 
ProjectAfter=network.target

[Service]
WorkingDirectory=/root
ExecStart=/usr/local/sbin/quota trojan
Restart=always

[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl restart qmtr
systemctl enable qmtr


sudo apt install sqlite3 -y

# Create SQLite database
sqlite3 /etc/xray/xray.db <<EOF

-- Create vmess table
CREATE TABLE vmess (
    user TEXT PRIMARY KEY,
    uuid TEXT,
    exp TEXT
);

-- Create vless table
CREATE TABLE vless (
    user TEXT PRIMARY KEY,
    uuid TEXT,
    exp TEXT
);

-- Create trojan table
CREATE TABLE trojan (
    user TEXT PRIMARY KEY,
    uuid TEXT,
    exp TEXT
);

-- Create shadowsocks table
CREATE TABLE shadowsocks (
    uswrname TEXT PRIMARY KEY,
    uuid TEXT,
    exp TEXT
);

EOF

echo "Database xray.db with tables vmess, vless, trojan, and shadowsocks created successfully."

mkdir -p /etc/cybervpn/limit/vmess/ip/
mkdir -p /etc/cybervpn/limit/vless/ip/
mkdir -p /etc/cybervpn/limit/trojan/ip/
mkdir -p /etc/cybervpn/limit/ssh/ip/
mkdir -p /etc/cybervpn/limit/noobs/ip/

mkdir -p /etc/vmess
mkdir -p /etc/vless
mkdir -p /etc/trojan
mkdir -p /etc/limit/vmess
mkdir -p /etc/limit/vless
mkdir -p /etc/limit/trojan




