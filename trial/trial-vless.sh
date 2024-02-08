#!/bin/bash

red() { echo -e "\\033[32;1m${*}\\033[0m"; }

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
domain=$(cat /etc/xray/domain)
clear
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
echo 1 > /etc/limit/vless/ip/${user}
uuid=$(cat /proc/sys/kernel/random/uuid)
Quota="1"
exp=`date -d "1 days" +"%Y-%m-%d"`
expi=`date -d "1 hours" +"%H:%M:%S"`
echo "Expiry date: $expi"
echo "#& $user $expi" >> /etc/trialxray.txt
sleep 1

sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json


if [ ! -e /etc/vless ]; then
  mkdir -p /etc/vless
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
  echo "${d}" >/etc/vless/${user}
fi

DATADB=$(cat /etc/vless/.vless.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
fi

echo "#& ${user} ${expe} ${uuid} ${Quota}" >>/etc/vless/.vless.db



vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

cat >/home/vps/public_html/vless-$user.yaml <<-END

# Format Vless WS TLS

- name: Vless-$user-WS TLS
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}

# Format Vless WS Non TLS

- name: Vless-$user-WS (CDN) Non TLS
  server: ${domain}
  port: 80
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: false
  skip-cert-verify: false
  servername: ${domain}
  network: ws
  ws-opts:
    path: /vless
    headers:
      Host: ${domain}
  udp: true

# Format Vless gRPC (SNI)

- name: Vless-$user-gRPC (SNI)
  server: ${domain}
  port: 443
  type: vless
  uuid: ${uuid}
  cipher: auto
  tls: true
  skip-cert-verify: true
  servername: ${domain}
  network: grpc
  grpc-opts:
  grpc-mode: gun
  grpc-service-name: vless-grpc
  udp: true



END

systemctl restart xray
systemctl restart nginx

DATADB=$(cat /root/akun/vless/.vless.conf | grep "^#&" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /root/akun/vless/.vless.conf
fi
echo "#& ${user} ${exp} ${uuid}" >>/root/akun/vless/.vless.conf

clear
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "\E[0;41;36m    Xray/Vless Account     \E[0m" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Remarks     : ${user}" | tee -a /root/akun/vless/$user.txt
echo -e "Domain      : ${domain}" | tee -a /root/akun/vless/$user.txt
echo -e "port TLS    : 443" | tee -a /root/akun/vless/$user.txt
echo -e "Port DNS    : 443" | tee -a /root/akun/vless/$user.txt
echo -e "Port NTLS   : 80" | tee -a /root/akun/vless/$user.txt
echo -e "User ID     : ${uuid}" | tee -a /root/akun/vless/$user.txt
echo -e "Encryption  : none" | tee -a /root/akun/vless/$user.txt
echo -e "Path TLS    : /vless " | tee -a /root/akun/vless/$user.txt
echo -e "ServiceName : vless-grpc" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link TLS    : ${vlesslink1}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link NTLS   : ${vlesslink2}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link GRPC   : ${vlesslink3}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Format OpenClash : http://${domain}:81/vless-$user.yaml" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Expired On : $exp" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "" | tee -a /root/akun/vless/$user.txt
read -n 1 -s -r -p "Press any key to back on menu"

menu
