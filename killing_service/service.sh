#!/bin/bash
clear

# Lunatic Tunneling
# Bandung Barat , saguling ,jati [ Indonesia ]

# Repo
GIT_CMD="https://raw.githubusercontent.com/ianexec/newltxv7/v7project/killing_service"

SERVICES=("kill-vme" "kill-vle" "kill-tro" "kill-ssh")

for service in "${SERVICES[@]}"; do
    FILE_PATH="/etc/systemd/system/${service}.service"    
  
    wget -q -O "$FILE_PATH" "${GIT_CMD}/${service}.service"
    
    if [[ ! -f "$FILE_PATH" ]]; then
        echo "Gagal mengunduh ${service}.service"
        exit 1
    fi

    chmod +x "$FILE_PATH"
    
    systemctl daemon-reload
    systemctl enable "$service"
    systemctl restart "$service"
    
    echo "Berhasil menjalankan ${service}"
done
