#!/bin/bash
set -e

CURRENT_DIR=$HOME/dotfiles
rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh

sudo mkdir -p /etc/sddm.conf.d

sudo tee /etc/sddm.conf.d/theme.conf > /dev/null <<EOF
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=silent
EOF

sudo systemctl enable -f sddm.service

echo -e "\n--- 目前的 SDDM 設定檔內容 ---"
cat /etc/sddm.conf.d/theme.conf

echo -e "\ninstall successful"
read -p "test? [Y/n]: " CONFIRM
CONFIRM=${CONFIRM,,}
if [[ $CONFIRM == "yes" || $CONFIRM == "y" || -z $CONFIRM ]]; then
    cd "${CURRENT_DIR}/sddm" && ./test.sh
fi


