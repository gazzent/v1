#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
install unzip -y
# Getting
clear
IP=$(curl -sS ipv4.icanhazip.com)
domain=$(cat /etc/xray/domain)
date=$(date +"%Y-%m-%d")
clear
email=$(cat /root/email)
if [[ "$email" = "" ]]; then
clear
echo -e "\033[1;93m┌──────────────────────────────────────────┐\033[0m"
echo -e "\033[1;96m    Masukkan Email Untuk Menerima Backup${NC}"
echo -e "\033[1;93m└──────────────────────────────────────────┘\033[0m"
echo -e ""
echo -e "---------------------------------------------------" | lolcat
read -rp "INPUT YOUR EMAIL:   " -e email
echo "$email" > /root/email
fi

clear
rm -rf /root/backup
mkdir /root/backup
cp /etc/passwd backup/
cp /etc/group backup/
cp /etc/shadow backup/
cp /etc/gshadow backup/
cp -r /etc/xray backup/xray
cp -r /var/www/html/ backup/html
cd /root
zip -r $IP-$date.zip backup > /dev/null 2>&1
rclone copy /root/$IP-$date.zip dr:backup/
url=$(rclone link dr:backup/$IP-$date.zip)
id=(`echo $url | grep '^https' | cut -d'=' -f2`)
link="https://drive.google.com/u/4/uc?id=${id}&export=download"
echo -e "
Detail Backup 
==================================
IP VPS        : $IP
Link Backup   : $link
Tanggal       : $date
==================================
" | mail -s "Backup Data" $email
 
source /root/cybervpn/var.txt && echo $BOT_TOKEN > .bot
azi=$(cat .bot)
source /root/cybervpn/var.txt && echo $ADMIN > .id
aji=$(cat .id)
curl -X POST https://api.telegram.org/bot$azi/sendDocument \
     -F "chat_id=$aji" \
     -F "document=@/root/$IP-$date.zip" \
     -F "caption=file backup mu" &> /dev/null

rm .bot
rm .id
rm -rf /root/backup
rm -r /root/$IP-$date.zip



