#!/bin/bash
set -e

rm -rf SilentSDDM
git clone -b main --depth=1 https://github.com/uiriansan/SilentSDDM && cd SilentSDDM && ./install.sh

sudo sed -i '/\[Theme\]/d' /etc/sddm.conf
sudo sed -i '/Current=/d' /etc/sddm.conf

sudo bash -c 'cat > /etc/sddm.conf <<EOF
[General]
InputMethod=qtvirtualkeyboard
GreeterEnvironment=QML2_IMPORT_PATH=/usr/share/sddm/themes/silent/components/,QT_IM_MODULE=qtvirtualkeyboard

[Theme]
Current=silent
EOF'

sudo systemctl enable sddm.service

echo -e "\n--- 目前的 SDDM 設定檔內容 ---"
cat /etc/sddm.conf

echo "install successful"
read -p "test? [Y/n]: " CONFIRM
CONFIRM=${CONFIRM,,}
if [[ $CONFIRM == "Y" || $CONFIRM == "y" || -z $CONFIRM ]]; then
    ./test.sh
fi


