#!/bin/bash
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CY='\033[0;36m'
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
export Server_URL="sc.funy.biz.id"
export Server_Port="443"
export Server_IP="192.168.121.60.179"
export Script_Mode="Stable"
export Author="Rerechan02 & PR_Aiman"

function garis() {
echo -e "${CY}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}" | lolcat
}

function create(){
clear

garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S CREATE°            \E[0m|"
garis
read -p "Username: " user
read -p "Password: " pass
read -p "Exp (0 for unlimited days):" exp
noobzvpns --add-user $user $pass --expired-user $user $exp
expi=`date -d "$exp days" +"%Y-%m-%d"`
systemctl restart noobzpns
clear

garis
echo -e "${CY}| \E[44;1;39m      °NOOBZVPN'S ACCOUNT°            \E[0m|"
garis
echo ""
echo -e "DOMAIN : $( cat /etc/xray/domain )"
echo -e "USERNAME: $user"
echo -e "PASSWORD: $pass"
echo -e "EXP DAYS: $exp DAYS [ $expi ]"
echo -e "tcp_std port: 80"
echo -e "tcp_ssl port: 443"
garis
echo -e "Example config TCP_STD"
garis
echo ""
echo -e "EFZZaNjbazXEI1p6zj32+XiWHKi7l86IDWgSkrQE8CGOAQF51Rp1Qp5tgqjCJLwQMh7EcFRFz/t3LDbj/oXl+cu6E8cGPpijz2tNIwreKaazj98RS5DE4CKjI4umYwUNhq7mUpdBussNAYIKLmAqIgL1EcwFcrMd0Zd1OliRWYghp3DRxiaeTAU85qDIYRREGIYEqWIGQ4nurSUVqrPugB2XcZE8naAw/xtManW7+QHMARl8QlaIa298sg2dXvSj+/JAVfypILMy3xhDTm3oBl35GnSxXS2iQNU0kozbGagDJnCOXt2FU5xmx/X9FI8KwAbdHWPzTKPQMbKPw6oABgUnIE13LVi4WenTR5BUoc7pDUFrLC8ssor4kToUz/F9s/lr9iPVtxEIpKUib/w7yI3VaXdoTdwtjGMLU8GdxY2aMUGidJuY5zY8Vgta9jfdeGLWSbbvK3ZjeFjmSjLwIfX/OQXDC439H6tV3/1o9l+hnRnWrZoWyOHLJfVlV86mLWMEZoOx9kCY8sJz2I50iBwrLcvkcwu8YnskuwrZTnA1nt9y7sMKlc4T8HMDmF9UqHvB3LKhtOaanUNmob6MwqqeEA=="
echo ""
garis
echo -e "Example config TCP_SSL"
garis
echo ""

echo -e "EHx0bOmSNzB/wWtLU6epQAQI3hvQZSXpMXWlw58Num2d3AToQLoKMbMQxYmQFlEYHn2AMsEla/xxnzflBE+irSh6pEziK7QRVonM1VxsNljQPUwhQc0GgiNuj07xuuNcvT5sdvETBhHHSSR/vLiVAbQ35fsB4hUjugWK9eoHQqZc9Mk/44qqUzYVxM9O1jMm7JciP/7rGi/pqC99ZjI2Wxi6of0eVuAuFq1oLF+/1r8qJws0PQRuFEK5JfIyMa6678w56VcHVSQbbMMTegxXXapEO8QTZ6p3f9VQQ4DQXLIvbwnGaWdVG91B0bAtV1SSk9MH2KRSj5gkI9/OBC9rdrvfgj7HQftfIATzbMXDHQZvgGe0NmO/MAZJcOMewooJPaM1ue2rT/z4MNsNSu1jA53l99H67JfVMn/euCpCYb6xzgpDnNoTiyk2BXzjcbE5FtgqjL8NE0f6sRBDR8DGEBjNtozSLewogZw6sp6uuSEz2hmoYRclkwyVLBvkDEvRJT8wny8hTwnRTH6TZjqLqfltGGfpGVr2YosAQqDTTAaxq1v9Yihuzl7vjOHBymnV4jGn+cdDlvfmcHNgxA=="
garis
echo -e ""
echo -e "Example Payload All Tunnel"
garis
echo -e ""

echo -e "GET / HTTP/1.1[crlf]Host: $(cat /etc/xray/domain)[crlf]Upgrade: websokcet[crlf][crlf]"
garis
}


function delete(){
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S DELETE°            \E[0m|"
garis
read -p "username :" user

noobzvpns --remove-user $user
systemctl restart noobzpns
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S DELETED!°            \E[0m|"
garis
echo "USERNAME: $user"
echo "Delete success!!"
garis
}


function renew(){
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S RENEW°            \E[0m|"
garis
read -p "username: " user
read -p "expired?: " exp
noobzvpns --renew-user $user --expired-user $user $exp
systemctl restart noobzpns
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S RENEW!°            \E[0m|"
garis
echo "USERNAME: $user"
echo "renew success!!"
garis
}




function lock(){
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S LOCK°            \E[0m|"
garis
read -p "username: " user
noobzvpns --block-user $user
systemctl restart noobzpns
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S LOCK!°            \E[0m|"
garis
echo "USERNAME: $user"
echo "locked success!!"
garis
}






function show(){

clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S MEMBER!°            \E[0m|"
garis
noobzvpns --info-all-user | awk '/^\s*\+.*-> active/ {gsub(/(issued\(yyyymmdd\)|hash_key): [0-9a-f]+/, ""); print; getline; print; getline; getline; getline; print; print "═══════════════════"}'

garis
}



function unlock(){
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S UNLOCK°            \E[0m|"
garis
read -p "username: " user
noobzvpns --unblock-user $user
systemctl restart noobzpns
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S UNLOCK!°            \E[0m|"
garis
echo "USERNAME: $user"
echo "unlocked success!!"
garis
}



function remove(){
clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S UNLOCK°            \E[0m|"
garis

read -p "Apakah Anda ingin menghapus semua user? (Y/N): " choice

if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
    # Eksekusi perintah di sini
    echo "MENGHAPUS SEMUA USER!"
noobzvpns --remove-all-user
systemctl restart noobzpns
elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
    echo "Membatalkan penghapusan."
nmenu
else
    echo "Pilihan tidak valid."
fi

clear
garis
echo -e "${GREEN}| \E[44;1;39m      °NOOBZVPN'S UNLOCK!°            \E[0m|"
garis
echo "USERNAME: $user"
echo "unlocked success!!"
garis
}




clear
echo -e "
===========================
<= [ NOOBZVPN'S SERVER ] =>
===========================

1. Create Noobzpn's Acount
2. Delete Noobzvpn's Acount
3. Renew Noobzvpn's Acount
4. Lock Acount Noobzvpn's
5. Unlock Acount Noobzvpn's
6. List Member Acount Noobzvpn's
7. Delete All Acount Noobzvpn's
0. Back To Menu
==========================="
echo -e ""
read -p " Select menu : " opt
echo -e ""
case $opt in
01 | 1) clear ; create ;;
02 | 2) clear ; delete ;;
03 | 3) clear ; renew ;;
04 | 4) clear ; lock ;;
05 | 5) clear ; unlock ;;
06 | 6) clear ; show ;;
07 | 7) clear ; remove ;;
00 | 0) clear ; menu ;;
*) clear ; menu ;;
esac
