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
echo -e "tcp_std port: 8080"
echo -e "tcp_ssl port: 8443"
garis
echo -e "Example config TCP_STD"
garis
echo ""
echo -e "EDoTObeIaReHNGpQjziTrIdkyxwPkx9XkeGjXDVB4IUdrWRV3ZkNm8ZjHZET4XjLBMJ2p2XrsdnoUs7r1/cu9YBRsLihz2i7u2P4NdN14gZkno/HP1gyf8dbaFJbejJ9NRaJ2cs6nj0cVPV8w9SDoFUteL4oV90U1BVJnM7w/t9xsnwj/RT5JlyiK8ClZrvobraMXeJWKVNm8J2Em+CeHYsmRQviY5G2Op7aLj4Y0ccYTlQHHbUcHfNK0Ov5RLK37Y+IJ7wv1DvC0qkky7GiGQXg9y8woLriiJXzNXyunjXTMmGaFCw7N1C1/5qO4zeshWSGhyJjMX5EyTmqcvJ7xLx0Wqst2q8Dv5DRAPpn+ApRyIkyTgNjSI5J/CZfvvDacBnR9weWA+4lx3UpPQvMmuUTTHFe/qASBROu8Xq1aw8oo2tztLaj9EODCdmc1+F3WIZyHadLjIruMCvnr6i+pYqZFY3UhsoXDz7RLY+j8iFwwlkdgSymaIQ/RQIGRJ1jDoxdjJ1lpJNpABu20hsfKRxoDjKbxw5hI6xSBcCTPQaDngoM2YnD6N00R7Ss9HvPDTpUc1Va2mt8nrMXAonnlOcCYbkxWVY2J8jswnPRADyJx4o="
echo ""
garis
echo -e "Example config TCP_SSL"
garis
echo ""

echo -e "EBBvYADmCAEAv3Qt5feYD0etmI1IVG5FlxHr9yTxiaPf88e+XlVY8J1EkuLPPHgzHsUAvd7k5FVkMHLOL5UQNNt6G6APszuJ2ydEYnraM7mL9wdI096TkD3fogTYXUu4mZ4pftaaI4OOjUq68urveF4eRTNPMdT3by7biHQ8l9npx0ovWD8uD/z+6qOxfrEXes7XAyZWJsfi8owM2cDz0d2476XHz/cSscKcb+He3vAlsjo6bsLqWwUNpB3QIku2RxydJwAcqYXYTteesdmPHmu2Ep51V+mpSWKNQePwOYkieSQKIROXF198O7K+Hoc3BhQ7Tdev7d2wgMLW61rzqlPRvzMRI1QWGsRIQrBEu4JuytxarB6EG2f9pOiH0ljKozyIHfCIw9yrm4w1BJ6Vt8zLkrZqd7wFkYneQl7VNoVnhWPiNIDVF2tMQCKlib7cE+1w0V6l2QjZPJ16frIQpd3hg74d1d3yN/QKejw32o09VHgyHL06aSdwE1RizPI85+G0aoT3UptGbcjDGRnFylZuHl9Y9dtHHppsJT+hqnRwUMEGqqqX0HbxJSsrKhvZHVUAZVaWIPbm2IQ="
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
============================================
<= [NOOBZVPNS SERVER BY CANDRA-VPN-STORE] =>
============================================

1. BUAT AKUN NOOBZVPN
2. HAPUS AKUN NOOBZVPN
3. PERPANJANG AKUN NOOBZVPN
4. KUNCI AKUN NOOBZVPN
5. UNLOCK AKUN NOOBZVPN
6. LIST PENGGUNA AKUN NOOBZVPN
7. HAPUS SEMUA AKUN NOOBZVPN
0. KEMBALI KE MENU UTAMA
============================================"
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
