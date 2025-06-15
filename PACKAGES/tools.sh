#!/bin/bash

rm -f $0

data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
url_izin="https://raw.githubusercontent.com/ianexec/permission/main/regist"
client=$(curl -sS $url_izin | grep $IP | awk '{print $2}')
exp=$(curl -sS $url_izin | grep $IP | awk '{print $3}')
today=`date -d "0 days" +"%Y-%m-%d"`
time=$(printf '%(%H:%M:%S)T')
date=$(date +'%d-%m-%Y')
d1=$(date -d "$exp" +%s)
d2=$(date -d "$today" +%s)
certifacate=$(((d1 - d2) / 86400))
checking_sc() {
  useexp=$(curl -s $url_izin | grep $IP | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    clear
    echo -e "\033[96m============================================\033[0m"
    echo -e "\033[44;37m           NotAllowed Autoscript         \033[0m"    
    echo -e "\033[96m============================================\033[0m"
    echo -e "\e[95;1m buy / sewa AutoScript installer VPS \e[0m"
    echo -e "\033[96m============================================\033[0m"    
    echo -e "\e[96;1m   1 IP        : Rp.10.000   \e[0m"
    echo -e "\e[96;1m   2 IP        : Rp.15.000   \e[0m"   
    echo -e "\e[96;1m   7 IP        : Rp.40.000   \e[0m"
    echo -e "\e[96;1m   Unli IP     : Rp.150.000  \e[0m"
    echo -e "\e[97;1m   open source : Rp.400.000  \e[0m"       
    echo -e ""
    echo -e "\033[96m============================================\033[0m"
    exit 0
  fi
}
checking_sc


clear
red='\e[1;31m'
green2='\e[1;32m'
yell='\e[1;33m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

echo "Process Install Dependencies"
sleep 1
apt update -y
apt upgrade -y
apt dist-upgrade -y
apt install sudo -y
sudo apt-get clean all
apt install -y debconf-utils
apt install haproxy -y
apt install p7zip-full -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
apt-get autoremove -y
apt install -y --no-install-recommends software-properties-common
echo iptables-persistent iptables-persistent/autosave_v4 boolean true | debconf-set-selections
echo iptables-persistent iptables-persistent/autosave_v6 boolean true | debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install iptables iptables-persistent netfilter-persistent figlet ruby libxml-parser-perl squid nmap screen curl jq bzip2 gzip coreutils rsyslog iftop htop zip unzip net-tools sed gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch screenfetch lsof openssl openvpn easy-rsa fail2ban tmux stunnel4 squid dropbear socat cron bash-completion ntpdate xz-utils apt-transport-https gnupg2 dnsutils lsb-release chrony libnss3-dev libnspr4-dev pkg-config libpam0g-dev libcap-ng-dev libcap-ng-utils libselinux1-dev libcurl4-openssl-dev flex bison make libnss3-tools libevent-dev xl2tpd apt git speedtest-cli p7zip-full libjpeg-dev zlib1g-dev python-is-python3 python3-pip shc build-essential nodejs nginx php php-fpm php-cli php-mysql p7zip-full squid libcurl4-openssl-dev
gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
curl -sL "$gotop_link" -o /tmp/gotop.deb
dpkg -i /tmp/gotop.deb

# remove unnecessary files
sudo apt-get autoclean -y >/dev/null 2>&1
audo apt-get -y --purge removd unscd >/dev/null 2>&1
sudo apt-get -y --purge remove samba* >/dev/null 2>&1
sudo apt-get -y --purge remove apache2* >/dev/null 2>&1
sudo apt-get -y --purge remove bind9* >/dev/null 2>&1
sudo apt-get -y remove sendmail* >/dev/null 2>&1
apt autoremove -y >/dev/null 2>&1
# finishing

yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "Dependencies successfully installed..."

cd
