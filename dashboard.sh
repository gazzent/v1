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
echo "status akun masih aktif" 
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

systemctl restart fail2ban

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
    status_dos="[${GREEN} ON${NC}]"
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



echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " ${YELLOW}• Today${NC}  : [$ttoday] ${YELLOW}• Monthly${NC}: [$tmon]"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW} SSH WS${NC} : ${status_ssh}  ${YELLOW}|Firewall${NC} : ${status_net} |${YELLOW} WAF STATUS${NC} : ${status_dos} |"
echo -e "${YELLOW} XRAY${NC}   : ${status_xray} ${YELLOW} |Fail2ban${NC} : ${status_fail2ban} |"
echo -e "${YELLOW} NGINX ${NC} : ${status_nginx}${YELLOW}  |iptables${NC} : ${status_net} |"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}│\033[0m ${BOLD}${YELLOW}SSH     VMESS     VLESS      TROJAN     SHADOW$NC  $COLOR1"
echo -e "${GREEN}│\033[0m ${Blue} $ssh1        $vma         $vla          $tra          $ssa   $NC"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
#echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
#echo -e "\E[39;1;92m                ⇱ MENU SERVICE ⇲                \E[0m"
#echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

#echo -e "${GREEN}┌──────────────────────────────────────────────────┐${NC}"

#echo -e " ${CYAN}[${BIWhite}01${BICyan}]${RED} •${NC} ${CYAN}SSH/CLOUDFRONT  $NC  ${CYAN}[${BIWhite}06${BICyan}]${RED} • ${NC}${CYAN}TROJAN MENU$NC"
#echo -e " ${CYAN}[${BIWhite}02${BICyan}]${RED} •${NC} ${CYAN}SSH UDP MENU    $NC  ${CYAN}[${BIWhite}07${BICyan}]${RED} • ${NC}${CYAN}IP SEC [ L2TP & PPTP ] $NC"
#echo -e " ${CYAN}[${BIWhite}03${BICyan}]${RED} •${NC} ${CYAN}VMESS MENU      $NC  ${CYAN}[${BIWhite}08${BICyan}]${RED} • ${NC}${CYAN}INFO RUNNING $NC"
#echo -e " ${CYAN}[${BIWhite}04${BICyan}]${RED} •${NC} ${CYAN}VLESS MENU      $NC  ${CYAN}[${BIWhite}09${BICyan}]${RED} • ${NC}${CYAN}TRIAL GENERATOR $NC"
#echo -e " ${CYAN}[${BIWhite}05${BICyan}]${RED} •${NC} ${CYAN}S-SOCK MENU     $NC  ${CYAN}[${BIWhite}10${BICyan}]${RED} • ${NC}${CYAN}DDOS PROTECTION V.12 $NC" 

#echo -e "${GREEN}└──────────────────────────────────────────────────┘${NC}"

echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "\E[39;1;92m                ⇱ MENU SERVICE ⇲                \E[0m"
echo -e "${PURPLE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"


echo -e " ${GREEN}"
echo -e "${GREEN}┌──────────────────────────────────────────────────┐${NC}"
echo -e "${GREEN}│ ${BOLD}${LIGHT}👉ID CLIENT  = $Name                           ${NC}"
echo -e "${GREEN}│ ${BOLD}${LIGHT}👉EXPIRED    = $Exp                           ${NC}"
echo -e "${GREEN}│ ${BOLD}${LIGHT}👉REMAINING  =  ${YELLOW}$left HARI                          ${NC}"
echo -e "${GREEN}│ ${BOLD}${LIGHT}👉DEVELOVER  = CANDRA SCRIPT TUNNEL                        ${NC}"
echo -e "${GREEN}│ ${BOLD}${LIGHT}👉VERSION    = 1.0.3 MOD SCRIPT                         ${NC}"

echo -e "${GREEN}└──────────────────────────────────────────────────┘${NC}"




