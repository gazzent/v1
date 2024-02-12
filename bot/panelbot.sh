#!/bin/bash
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'



function sett(){
clear

azi=$(cat /root/nsdomain)
domain=$(cat /etc/xray/domain)
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m            ⇱ admin panel setting ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -p "Masukan bot token :" bot
read -p "Masukan ID telegram :" id
read -p "Masukan username telegram :" user

rm -f /media/.private/cybervpn/var.txt

cat > /media/.private/cybervpn/var.txt << END
ADMIN="$id"
BOT_TOKEN="$bot"
DOMAIN="$domain"
DNS="$azi"
PUB="7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59"
OWN="$user"
SALDO="100000"
END

systemctl restart cybervpn
clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m    ⇱ success add new bot ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"

echo "Api Token     : $token"
echo "ID            : $admin"
echo "DOMAIN        : $domain"
echo "NS            : $azi"
echo "PUB           : 7fbd1f8aa0abfe15a7903e837f78aba39cf61d36f183bd604daa2fe4ef3b7b59"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
}


cybervpn_service=$(systemctl status cybervpn | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)

# STATUS SERVICE  SQUID 
if [[ $cybervpn_service == "running" ]]; then 
   status_cybervpn=" ${GREEN}Running ${NC}"
else
   status_cybervpn="${RED}  Not Running ${NC}"
fi
clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "\E[44;1;39m            ⇱ bot panel cybervpn ⇲             \E[0m"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${LIGHT}"
echo -e "STATUS CYBERVPN: $cybervpn_service"
echo -e "1.START BOT"
echo -e "2.STOP BOT"
echo -e "3.Edit bot/id telegram/domain"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -p "PILIH NOMOR:" bro

case $bro in
01 | 1) clear ; systemctl restart cybervpn && panelbot ;;
02 | 2) clear ; systemctl stop cybervpn && panelbot ;;
03 | 3) clear ; sett ;;
100) clear ; $up2u ;;
00 | 0) clear ; menu1 ;;
*) clear ; menu1 ;;
esac