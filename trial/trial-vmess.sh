#!/bin/bash

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
source /var/lib/scrz-prem/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi

tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"

user=Cyber`</dev/urandom tr -dc X-Z0-9 | head -c4`
echo 1 > /etc/limit/vmess/ip/${user}

uuid=$(cat /proc/sys/kernel/random/uuid)
Quota="1"
exp=`date -d "1 days" +"%Y-%m-%d"`
expi=`date -d "1 hours" +"%H:%M:%S"`
echo "Expiry date: $expi"
echo "### $user $expi" >> /etc/trialxray.txt
sleep 1
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json

if [ ! -e /etc/vmess ]; then
  mkdir -p /etc/vmess
fi

if [ -z ${iplim} ]; then
  iplim="0"
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))
if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vmess/${user}
fi

DATADB=$(cat /etc/vmess/.vmess.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vmess/.vmess.db
fi

echo "### ${user} ${expe} ${uuid} ${Quota}" >>/etc/vmess/.vmess.db

asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
systemctl restart xray > /dev/null 2>&1
service cron restart > /dev/null 2>&1
systemctl restart nginx > /dev/null 2>&1

cat >/home/vps/public_html/vmess-$user.yaml <<-END

# Format Vmess WS TLS

- name: Vmess-$user-WS TLS
  type: vmess
  server: ${domain}
  port: 443
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess WS Non TLS

- name: Vmess-$user-WS Non TLS
  type: vmess
  server: ${domain}
  port: 80
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  udp: true
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vmess
    headers:
      Host: ${domain}

# Format Vmess gRPC

- name: Vmess-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vmess
  uuid: ${uuid}
  alterId: 0
  cipher: auto
  network: grpc
  tls: true
  servername: ${domain}
  skip-cert-verify: true
  grpc-opts:
    grpc-service-name: vmess-grpc


END

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "\\E[0;41;36m      TRIAL  XRAY/Vmess Account        \E[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Remarks          : ${user}" | tee -a /root/akun/vmess/$user.txt
echo -e "Domain           : ${domain}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port TLS         : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port none TLS    : ${none}" | tee -a /root/akun/vmess/$user.txt
echo -e "Port  GRPC       : ${tls}" | tee -a /root/akun/vmess/$user.txt
echo -e "id               : ${uuid}" | tee -a /root/akun/vmess/$user.txt
echo -e "alterId          : 0" | tee -a /root/akun/vmess/$user.txt
echo -e "Security         : auto" | tee -a /root/akun/vmess/$user.txt
echo -e "Network          : ws" | tee -a /root/akun/vmess/$user.txt
echo -e "Path             : /Multi-Path" | tee -a /root/akun/vmess/$user.txt
echo -e "Dynamic          : http://bugmu.com/path" | tee -a /root/akun/vmess/$user.txt
echo -e "ServiceName      : vmess-grpc" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link TLS         : ${vmesslink1}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link none TLS    : ${vmesslink2}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Link GRPC        : ${vmesslink3}" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Format OpenClash : http://${domain}:81/vmess-$user.yaml" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo -e "Expired On       : $exp" | tee -a /root/akun/vmess/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/vmess/$user.txt
echo "" | tee -a /root/akun/vmess/$user.txt
read -n 1 -s -r -p "Press any key to back on menu"

menu
