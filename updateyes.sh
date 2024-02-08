
#!/bin/bash

hosting=$(curl -sS https://raw.githubusercontent.com/Azigaming404/Autoscript-by-azi/main/domain)
LocalVersion=$(cat /etc/version)
version=$(curl -sS "https://raw.githubusercontent.com/gazzent/v1/main/versiupdate")

if [ "$LocalVersion" = "$version" ]; then
  echo
else
  clear
  figlet -f 3d "CandvpnZ" | lolcat
  echo "Update tersedia!!" | lolcat
  echo "fix issue" | lolcat

  spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
      local temp=${spinstr#?}
      printf " [%c] " "$spinstr"
      local spinstr=$temp${spinstr%"$temp"}
      sleep $delay
      printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
  }

  loading_animation() {
    local message=$1
    echo -n "$message"
    $2 &
    spinner $!
  }

  echo "Sedang mengupdate!!!"

  loading_animation "Loading" "sleep 5"

  fun_bar() {
    CMD[0]="$1"
    CMD[1]="$2"
    (
      [[ -e $HOME/fim ]] && rm $HOME/fim
      ${CMD[0]} -y >/dev/null 2>&1
      ${CMD[1]} -y >/dev/null 2>&1
      touch $HOME/fim
    ) >/dev/null 2>&1 &
    tput civis
    echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    while true; do
      for ((i = 0; i < 18; i++)); do
        echo -ne "\033[0;32m#"
        sleep 0.1s
      done
      [[ -e $HOME/fim ]] && rm $HOME/fim && break
      echo -e "\033[0;33m]"
      sleep 1s
      tput cuu1
      tput dl1
      echo -ne "  \033[0;33mPlease Wait Loading \033[1;37m- \033[0;33m["
    done
    echo -e "\033[0;33m]\033[1;37m -\033[1;32m OK !\033[1;37m"
    tput cnorm
  }
  fun_bar


##root###############
  
#wget -q -O /etc/version "https://$hosting/Autoscript-by-azi-main/versiupdate" && chmod +x /etc/version

#wget -q -O /usr/bin/menu-ssh "https://$hosting/Autoscript-by-azi-main/menu-ssh.sh" && chmod 777 /usr/bin/menu-ssh
######$###############

rm -f /usr/bin/menu-tojan

wget -q -O /usr/bin/menu-tojan "https://raw.githubusercontent.com/gazzent/v1/main/tes/menu-trojan.sh" && chmod 777 /usr/bin/menu-tojan



#wget -q -O /media/cybervpn/__init__.py "https://cybervpn.serv00.net/Autoscript-by-azi-main/__init__.py"


#wget -q -O /media/cybervpn/modules/trojan.py "https://cybervpn.serv00.net/Autoscript-by-azi-main/trojan.py"

#wget -q -O /media/cybervpn/modules/shadowsocks.py "https://cybervpn.serv00.net/Autoscript-by-azi-main/shadowsocks.py"


#rm -f /media/cybervpn.session

systemctl restart cybervpn






#wget -q -O /usr/bin/renewws "http://$hosting/Autoscript-by-azi-main/botssh/renewws.sh" && chmod +x /usr/bin/renewws

systemctl restart cybervpn






fi
