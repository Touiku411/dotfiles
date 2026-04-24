#!/bin/bash
green='\033[0;32m'
red='\033[0;31m'
bred='\033[1;31m'
cyan='\033[0;36m'
grey='\033[2;37m'
reset="\033[0m"

THEMES_DIR="/usr/share/sddm/themes"
SDDM_CONF="/etc/sddm.conf.d/theme.conf"

CURRENT_THEME=$(grep "^Current" "$SDDM_CONF" | cut -d'=' -f2)

if [ -z "$CURRENT_THEME" ]; then
    echo -e "${bred}[ERROR] Can't find Current={your theme} in /etc/sddm.conf.d/theme.conf${reset}"
    exit 1
fi

THEME_PATH="${THEMES_DIR}/${CURRENT_THEME}"
if [ -d "$THEME_PATH" ]; then
    QT_IM_MODULE=qtvirtualkeyboard QML2_IMPORT_PATH="${THEME_PATH}/components/" sddm-greeter-qt6 --test-mode --theme "$THEME_PATH" > /dev/null 2>&1
else
    echo -e "${bred}[ERROR]${THEME_PATH} doesn't exists ${reset}"
    exit 1
fi


