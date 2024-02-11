#!/bin/bash



export RED='\033[0;31m'
export GREEN='\033[0;36m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;35m'
export LIGHT='\033[0;37m'
export NC='\033[0m'




function vmess(){
clear
echo "Switching multipath xray to vmess by cybervpn" | lolcat
echo "${RED}STOP NGINX"

systemctl stop nginx
rm -f /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf "https://cybervpn.serv00.net/Autoscript-by-azi-main/configuration/vmess.txt"
chmod +x /etc/nginx/conf.d/xray.conf


echo "${GREEN}START NGINX OK"
echo "${GREEN}START XRAY OK"
systemctl restart nginx
systemctl restart xray

}





function vless(){
clear
echo "Switching multipath xray to vless by cybervpn" | lolcat
echo "${RED}STOP NGINX"

systemctl stop nginx
rm -f /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf "https://cybervpn.serv00.net/Autoscript-by-azi-main/configuration/vless.txt"
chmod +x /etc/nginx/conf.d/xray.conf


echo "${GREEN}START NGINX OK"
echo "${GREEN}START XRAY OK"
systemctl restart nginx
systemctl restart xray

}






function trojan(){
clear
echo "Switching multipath xray to trojan by cybervpn" | lolcat
echo "${RED}STOP NGINX"

systemctl stop nginx
rm -f /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf "https://cybervpn.serv00.net/Autoscript-by-azi-main/configuration/vless.txt"
chmod +x /etc/nginx/conf.d/xray.conf


echo "${GREEN}START NGINX OK"
echo "${GREEN}START XRAY OK"
systemctl restart nginx
systemctl restart xray

}






function ss(){
clear
echo "Switching multipath xray to vmess by cybervpn" | lolcat
echo "${RED}STOP NGINX"

systemctl stop nginx
rm -f /etc/nginx/conf.d/xray.conf
wget -q -O /etc/nginx/conf.d/xray.conf "https://cybervpn.serv00.net/Autoscript-by-azi-main/configuration/vless.txt"
chmod +x /etc/nginx/conf.d/xray.conf

echo "${GREEN}START NGINX OK"
echo "${GREEN}START XRAY OK"
systemctl restart nginx
systemctl restart xray

}






clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\E[0;41;36m        MULTIPATH ALL XRAY MENU           \E[0m"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "${NC}select xray protocol to support multipath!!"
echo ""
echo -e "[01].VMESS FOR MULTI PATH /vmess - /whatever"
echo -e "[02].VLESS FOR MULTI PATH /vless - /whatever"
echo -e "[03].TROJAN FOR MULTI PATH /trojan - /whatever"
echo -e "[04].SHADOWSOCKS FOR MULTI PATH /ss - /whatever"
echo -e ""
 echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

echo -e "⚠️WARNING!! Do not use xray/v2ray vpn 
\nwhen using this feature, as it will \ncause you to bounce off the server \nwhich will result in nginx shutting down...!!"
echo -e ""
 echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"


echo -e "     ${BIYellow}Press x or [ Ctrl+C ] • To-${BIWhite}Exit${NC}"
echo ""
read -p " Select menu : " opt
echo -e ""
case $opt in
1) clear ; vmess ;;
2) clear ; vless ;;
3) clear ; trojan;;
4) clear ; ss ;;
0) clear ; menu ;;
x) exit ;;
*) echo -e "" ; echo "Press any key to back on menu" ; sleep 1 ; menu ;;
esac









