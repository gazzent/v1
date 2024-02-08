#!/bin/bash

# Getting
MYIP=$(wget -qO- ipinfo.io/ip);
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/xray/domain)
else
domain=$IP
fi
tr="$(cat ~/log-install.txt | grep -w "Trojan WS " | cut -d: -f2|sed 's/ //g')"

clear
user=Trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
echo 1 > /etc/limit/trojan/ip/${user}
uuid=$(cat /proc/sys/kernel/random/uuid)
Quota="1"
exp=`date -d "1 days" +"%Y-%m-%d"`
expi=`date -d "1 hours" +"%H:%M:%S"`
echo "Expiry date: $expi"
echo "#! $user $expi" >> /etc/trialxray.txt
sleep 1
sed -i '/#trojanws$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojangrpc$/a\#! '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json

if [ ! -e /etc/trojan ]; then
  mkdir -p /etc/trojan
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/trojan/${user}
fi
DATADB=$(cat /etc/trojan/.trojan.db | grep "^#!" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/trojan/.trojan.db
fi
echo "#! ${user} ${exp} ${uuid} ${Quota}" >>/etc/trojan/.trojan.db


# Link Trojan Akun
systemctl restart xray
trojanlink1="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink="trojan://${uuid}@bugkamu.com:443?path=%2Ftrojan-ws&security=tls&host=${domain}&type=ws&sni=${domain}#${user}"

cat >/home/vps/public_html/trojan-$user.yaml <<-END

# Format Trojan GO/WS

- name: Trojan-$user-GO/WS
  server: ${domain}
  port: 443
  type: trojan
  password: ${uuid}
  network: ws
  sni: ${domain}
  skip-cert-verify: true
  udp: true
  ws-opts:
    path: /trojan-ws
    headers:
        Host: ${domain}

# Format Trojan gRPC

- name: Trojan-$user-gRPC
  type: trojan
  server: ${domain}
  port: 443
  password: ${uuid}
  udp: true
  sni: ${domain}
  skip-cert-verify: true
  network: grpc
  grpc-opts:
    grpc-service-name: trojan-grpc

END

clear
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "\E[0;41;36m          TRIAL TROJAN ACCOUNT           \E[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "Remarks          : ${user}" | tee -a /root/akun/trojan/$user.txt
echo -e "Host/IP          : ${domain}" | tee -a /root/akun/trojan/$user.txt
echo -e "port             : 443" | tee -a /root/akun/trojan/$user.txt
echo -e "Key              : ${uuid}" | tee -a /root/akun/trojan/$user.txt
echo -e "Path             : /trojan-ws" | tee -a /root/akun/trojan/$user.txt
echo -e "ServiceName      : trojan-grpc" | tee -a /root/akun/trojan/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "Link WS          : ${trojanlink}" | tee -a /root/akun/trojan/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "Link GRPC        : ${trojanlink1}" | tee -a /root/akun/trojan/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "Format OpenClash : http://${domain}:81/trojan-$user.yaml" | tee -a /root/akun/trojan/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo -e "Expired On       : $exp" | tee -a /root/akun/trojan/$user.txt
echo -e "\033[0;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m" | tee -a /root/akun/trojan/$user.txt
echo "" | tee -a /root/akun/trojan/$user.txt
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
