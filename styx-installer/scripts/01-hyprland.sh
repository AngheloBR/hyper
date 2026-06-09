#!/usr/bin/env bash

GREEN="\e[32m"
PURPLE="\e[35m"
ENDCOLOR="\e[0m"

msg() {
  echo -e "${PURPLE}[Styx-Core]${ENDCOLOR} ${GREEN}$1${ENDCOLOR}"
}

msg "Instalando Hyprland y componentes de video..."
sudo pacman -S --noconfirm hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland

msg "Instalando la interfaz (Waybar vertical, Rofi-Wayland y SWWW)..."
sudo pacman -S --noconfirm waybar rofi-wayland swwwgrim slurp wl-clipboard cliphist

msg "Asegurando aplicaciones del usuario (Ghostty y Thunar)..."
sudo pacman -S --noconfirm ghostty thunar thunar-archive-plugin

msg "Componentes de Styx x Anghelo BR descargados."
