#!/bin/bash

clear
echo -e "\033[96;1m =============================== \033[0m"
echo -e "\033[96;1m  WILDCARD RANDOM SUBDOMAIN VPS \033[0m"    
echo -e "\033[96;1m =============================== \033[0m"    

IP=$(curl -sS ipv4.icanhazip.com)
DOMAIN=ltexec.xyz

# Generate subdomain acak
RANDOM_SUB=$(head /dev/urandom | tr -dc a-z0-9 | head -c 8)

# Buat wildcard DNS-nya
WILDCARD="*.$RANDOM_SUB.$DOMAIN"
CF_KEY=88a8619c3dec8a0c9a14cf353684036108844
CF_ID=newvpnlunatix293@gmail.com

echo ""
echo "Proses Pointing Wildcard Domain ${WILDCARD}..."
sleep 1

ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILDCARD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${WILDCARD}'","content":"'${IP}'","ttl":120,"proxied":true}' | jq -r .result.id)
else
     curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${WILDCARD}'","content":"'${IP}'","ttl":120,"proxied":true}' > /dev/null
fi

# Simpan domain utama (tanpa wildcard) untuk kebutuhan lain
MAIN_SUB="$RANDOM_SUB.$DOMAIN"
echo "$MAIN_SUB" > /etc/xray/domain

clear
echo -e "\033[96m=======================================\033[0m"    
echo -e "\e[96;1mWILDCARD DOMAIN AKTIF:\e[0m *.$MAIN_SUB"
echo -e "\e[96;1mCONTOH BISA DIAKSES:\e[0m bebasbanget.$MAIN_SUB"
echo -e "\033[96m=======================================\033[0m"
sleep 2
