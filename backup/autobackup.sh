#!/bin/bash
# cybervpn
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
# Getting
clear
IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d");
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
cek=$(grep -c -E "^# BEGIN_Backup" /etc/crontab)
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi
function start() {
id=$(cat /root/id)
if [[ "$id" = "" ]]; then
echo "Please enter your id telegram"
read -rp "id telegram : " -e tel
echo "$tel" > /root/id
fi

cat << EOF >> /etc/crontab
# BEGIN_Backup
5 0 * * * root mbackup
# END_Backup
EOF
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Started"
echo " Data Will Be Backed Up Automatically at 00:05 GMT +7"
exit 0
}
function stop() {
id=$(cat /root/id)
sed -i "/^$id/d" /root/id
sed -i "/^# BEGIN_Backup/,/^# END_Backup/d" /etc/crontab
service cron restart
sleep 1
echo " Please Wait"
clear
echo " Autobackup Has Been Stopped"
exit 0
}

function gantipenerima() {
nano /root/cybervpn/var.txt
}

function email() {

rm -rf /root/email
echo "Please enter your email"
read -rp "Email : " -e email
echo "$email" > /root/email
}


function testemail() {
email=$(cat /root/email)

source /root/cybervpn/var.txt && echo $BOT_TOKEN > .bot
azi=$(cat .bot)
source /root/cybervpn/var.txt && echo $ADMIN > .id
aji=$(cat .id)

send_message() {
    message=$1
    curl -s -X POST https://api.telegram.org/bot$azi/sendMessage -d chat_id=$aji -d text="$message"
}

send_message "Halo! Ini adalah pesan percobaan backup bot." &> /dev/null


echo -e "
Ini adalah isi email percobaaan kirim email dari vps
IP VPS : $IP
Tanggal : $date
" | mail -s "Percobaan Pengiriman Email" $email

echo "Terkirim!!"
}


function mailpengirim() {
echo "Please enter your email"
read -rp "Email : " -e email
echo "Please enter your Password email"
read -rp "Password : " -e pwdd
rm -rf /etc/msmtprc
cat<<EOF>>/etc/msmtprc
defaults
tls on
tls_starttls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
account default
host smtp.gmail.com
port 587
auth on
user $email
from $email
password $pwdd
logfile ~/.msmtp.log
EOF
}

clear
echo -e "=============================="
echo -e "     Autobackup Data $sts     "
echo -e "=============================="
echo -e "1. Start Autobackup"
echo -e "2. Stop Autobackup"
echo -e "3. Ganti id telegram dan bot Penerima (include bot panel)"
echo -e "4. Ganti email penerima"
echo -e "5. tes kirim pesan"
echo -e "6. ganti email pengirim"
echo -e "=============================="
read -rp "Please Enter The Correct Number : " -e num
case $num in
01 | 1) clear ; start ;;
02 | 2) clear ; stop ;;
03 | 3) clear ; gantipenerima ;;
04 | 4) clear ; email ;;
05 | 5) clear ; testemail ;;
06 | 6) clear ; mailpengirim ;;
100) clear ; $up2u ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
