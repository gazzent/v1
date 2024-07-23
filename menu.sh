#!/bin/bash
# =========================================
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2
COLOR1='\033[0;35m'
COLOR2='\033[0;39m'
clear
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;36m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;35m'
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

# // Exporting URL Host
export Server_URL="autosc.me/aio"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="CANDRAvpnz"
# Getting
MYIP=$(curl ipv4.icanhazip.com);
echo -e "VERIFIKASI IZIN IP VPS"
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/gazzent/ip/main/ip | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
echo -e "verifikasi IP di terima"
    else
echo -e "\e[31manda di tolak!\e[0m"
    exit 
fi
}

if [ ! -e /tmp/trojan ]; then
  mkdir -p /tmp/trojan
fi

if [ ! -e /tmp/vmess ]; then
  mkdir -p /tmp/vmess
fi

if [ ! -e /tmp/vless ]; then
  mkdir -p /tmp/vless
fi

IZIN=$(curl -sS https://raw.githubusercontent.com/gazzent/ip/main/ip | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo "STATUS IZIN IP VPS ANDA AKTIF BRO" 
CEKEXPIRED 
else
echo -e "\e[31mSCRIPT ANDA EXPIRED!\e[0m"
exit 0
fi
# status
rm -rf /root/status
wget -q -O /root/status "https://raw.githubusercontent.com/gazzent/v1/main/statushariini" 

today=`date -d "0 days" +"%Y-%m-%d"`
Exp2=$(curl -sS https://raw.githubusercontent.com/gazzent/ip/main/ip | grep $MYIP | awk '{print $3}')
if [ "$Exp2" == "lifetime" ]; then
    Exp2="2099-12-09"
fi
# CERTIFICATE STATUS
d1=$(date -d "$Exp2" +%s)
d2=$(date -d "$today" +%s)
left=$(((d1 - d2) / 86400))


datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    echo -e "$COLOR1 $NC Expiry In   : $(( (d1 - d2) / 86400 )) Days"
}


# // Root Checking
if [ "${EUID}" -ne 0 ]; then
                echo -e "${EROR} Please Run This Script As Root User !"
                exit 1
fi
tomem="$(free | awk '{print $2}' | head -2 | tail -n 1 )"
usmem="$(free | awk '{print $3}' | head -2 | tail -n 1 )"
cpu1="$(mpstat | awk '{print $4}' | head -4 |tail -n 1)"
cpu2="$(mpstat | awk '{print $6}' | head -4 |tail -n 1)"
#update
rm -f updatsc.sh
#wget -q -O updatsc.sh "https://raw.githubusercontent.com/gazzent/v1/main/updateyes.sh" && chmod +x updatsc.sh && ./updatsc.sh 
rm -f updatsc.sh
# // Exporting IP Address
export MYIP=$( curl -s ipv4.icanhazip.com )
Name=$(curl -sS https://raw.githubusercontent.com/gazzent/ip/main/ip | grep $MYIP | awk '{print $2}')
Exp=$(curl -sS https://raw.githubusercontent.com/gazzent/ip/main/ip | grep $MYIP | awk '{print $3}')

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="ON"
else
    status_nginx="OFF"
fi
# // 
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="ON"
else
    status_xray="OFF"
fi

# // SSH Websocket Proxy
ssh=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_ssh="ON"
else
    status_ssh="OFF"
fi

## // ddos
dos=$( systemctl status ddos | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $dos == "running" ]]; then
    status_dos="ON"
else
    status_dos="OFF"
fi


## // fail2ban
fail2ban=$( systemctl status fail2ban | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $fail2ban == "running" ]]; then
    status_fail2ban="ON"
else
    status_fail2ban="OFF"
fi


## // net
netfilter=$( systemctl status netfilter-persistent | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $netfilter == "exited" ]]; then
    status_net="ON"
else
    status_net="OFF"
fi









ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}' | head -1)"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}' | head -1)"
bot
clear

echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${PURPLE}| \E[39;1;92m        SCRIPT PREMIUM BY KINGSTORES        \E[0m ${PURPLE}|"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e "${YELLOW}• SERVER UPTIME = $( uptime -p  | cut -d " " -f 2-10000 ) " 
echo -e "${YELLOW}• CURRENT TIME  = $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "${YELLOW}• DOMAIN VPS    = $( cat /etc/xray/domain )"
echo -e "${YELLOW}• IP VPS        = $MYIP"
echo -e "${YELLOW}• ISP VPS       = $(curl -s ipinfo.io/org | cut -d " " -f 2-10 )${NC}"
echo -e "${YELLOW}• PESAN ADMIN   = $(cat /root/status)${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo -e " ${YELLOW}• Today${NC}  : [$ttoday] ${YELLOW}• Monthly${NC}: [$tmon]"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW} SSH WS${NC} : ${status_ssh}  ${YELLOW}|Firewall${NC} : ${status_net} |${YELLOW} WAF STATUS${NC} : ${status_dos} |"
echo -e "${YELLOW} XRAY${NC}   : ${status_xray} ${YELLOW} |Fail2ban${NC} : ${status_fail2ban} |"
echo -e "${YELLOW} NGINX ${NC} : ${status_nginx}${YELLOW}  |iptables${NC} : ${status_net} |"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}│\033[0m ${BOLD}${YELLOW}SSH     VMESS     VLESS      TROJAN     SHADOW$NC  $COLOR1"
echo -e "${GREEN}│\033[0m ${Blue} $ssh1        $vma         $vla          $tra          $ssa   $NC"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[39;1;92m                ⇱ MENU SERVICE ⇲                \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${CYAN}[${BIWhite}01${BICyan}]${BLUE} > ${NC} ${CYAN}MENU SSH WS $NC  ${CYAN}[${BIWhite}06${BICyan}]${RED} > ${NC}${CYAN}MENU TRIAL$NC"
echo -e " ${CYAN}[${BIWhite}02${BICyan}]${BLUE} > ${NC} ${CYAN}MENU VMESS  $NC  ${CYAN}[${BIWhite}07${BICyan}]${RED} > ${NC}${CYAN}INFO RUNNING$NC"
echo -e " ${CYAN}[${BIWhite}03${BICyan}]${BLUE} > ${NC} ${CYAN}MENU VLESS  $NC  ${CYAN}[${BIWhite}08${BICyan}]${RED} > ${NC}${CYAN}SETTING SC $NC"
echo -e " ${CYAN}[${BIWhite}04${BICyan}]${BLUE} > ${NC} ${CYAN}MENU TOJAN  $NC  ${CYAN}[${BIWhite}09${BICyan}]${RED} > ${NC}${CYAN}MENU BOT PANEL$NC"
echo -e " ${CYAN}[${BIWhite}05${BICyan}]${BLUE} > ${NC} ${CYAN}S-SOCK MENU $NC  ${CYAN}[${BIWhite}10${BICyan}]${RED} > ${NC}${CYAN}FIX UDP JIKA OFF $NC" 
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[39;1;92m                ⇱ NEW SERVICE ⇲                \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${CYAN}[${BIWhite}11${BICyan}]${BLUE} > ${NC} ${CYAN}MULTIPATH MENU $NC ${CYAN}[${BIWhite}14${BICyan}]${RED} > ${NC}${CYAN}CONF VMESS$NC"
echo -e " ${CYAN}[${BIWhite}12${BICyan}]${BLUE} > ${NC} ${CYAN}NOOBZ MENU     $NC ${CYAN}[${BIWhite}15${BICyan}]${RED} > ${NC}${CYAN}CONF VLESS$NC"
echo -e " ${CYAN}[${BIWhite}13${BICyan}]${BLUE} > ${NC} ${CYAN}CONF TROJAN    $NC ${CYAN}[${BIWhite}16${BICyan}]${RED} > ${NC}${CYAN}REGIST RESELLER$NC"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}│ ${YELLOW}${YELLOW}👉ID CLIENT  >>  ${YELLOW}$Name                           ${NC}"
echo -e "${BLUE}│ ${YELLOW}${YELLOW}👉REMAINING  >>  ${GREEN}$left HARI | ${YELLOW}$Exp        ${NC}"
echo -e "${BLUE}│ ${YELLOW}${YELLOW}👉DEVELOVER  >>  ${RED}CANDRA VPN ${YELLOW}TUNNEL              ${NC}"
echo -e "${BLUE}│ ${YELLOW}${YELLOW}👉VERSION    >>  ${RED}V 1.4 ${YELLOW}MODZ SCRIPT                         ${NC}"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo
read -p " Select menu (1-10) : " opt
echo -e ""
case $opt in
01 | 1) clear ; menu-ssh ;;
02 | 2) clear ; menu-vmess ;;
03 | 3) clear ; menu-vless ;;
04 | 4) clear ; menu-trojan ;;
05 | 5) clear ; menu-ss ;;
06 | 6) clear ; menu-trial ;;
07 | 7) clear ; running ;;
08 | 8) clear ; setting ;;
09 | 9) clear ; panelbot ;;
10) clear ; clear ; curl "https://raw.githubusercontent.com/Azigaming404/Autoscript-by-azi/main/udp/udp-custom.sh" | bash ;;
99) clear ; menu1 ;;
16) clear ; bash admin-ip ;;
11) clear ; menu-multipath ;;
12) clear ; menu-noobzvpns ;;
14) clear ; user-ws ;;
15) clear ; user-vless ;;
13) clear ; user-tr ;;
100) clear ; $up2u ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
