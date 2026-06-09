#!/usr/bin/env bash

GREEN="\e[32m"
PURPLE="\e[35m"
ENDCOLOR="\e[0m"

msg() {
  echo -e "${PURPLE}[Styx-Base]${ENDCOLOR} ${GREEN}$1${ENDCOLOR}"
}

msg "Actualizando repositorios y base del sistema..."
sudo pacman -Syu --noconfirm

msg "Instalando herramientas esenciales de compilación y control..."
sudo pacman -S --noconfirm --needed base-devel git wget curl brightnessctl pipewire wireplumber

msg "Dependencias base listas."
