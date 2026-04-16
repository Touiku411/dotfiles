#!/bin/bash

set -e
DOT_DIR="$HOME/dotfiles"

PKGS_PACMAN=(
    "hyprland"
    "kitty"
    "waybar"
    "rofi-wayland"
    "swaync"       
    "cava"     
    "fastfetch"
    "matugen"
    "git" "base-devel"
)
PKGS_AUR=(
    "wlogout"
    "waypaper"
    "visual-studio-code-bin"
)

sudo pacman -Syu --noconfirm

echo "install pacman pkgs..."
sudo pacman -S --noconfirm "${PKGS_PACMAN[@]}"

if ! command -v yay &> /dev/null; then
    echo "install yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

echo "install yay pkgs..."
yay -S --noconfirm "${PKGS_AUR[@]}"

echo "link..."
mkdir -p ~/.config
CONFIG_APPS=("hypr" "kitty" "waybar" "rofi" "swaync" "wlogout" "cava" "fastfetch" "matugen")


for app in "${CONFIG_APPS[@]}"; do
    if [ -d "$DOT_DIR/.config/$app" ]; then
        rm -rf "$HOME/.config/$app"
        ln -sf "$DOT_DIR/.config/$app" "$HOME/.config/"
        echo "link $app"
    else
        echo "can not find $DOT_DIR/.config/$app... skip..."
    fi
done
