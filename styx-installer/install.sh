#!/usr/bin/env bash

clear
echo -e "\e[35m"
echo "  ____  _             _              _                  _          _      "
echo " / ___|| |_ _   _ ___(_)  __    _   / \   _ __   __ _  | |__   ___| | ___ "
echo " \___ \| __| | | |_  / |  \ \  / / / _ \ | '_ \ / _\` | | '_ \ / _ \ |/ _ \\"
echo "  ___) | |_| |_| |/ /| |   \ \/ / / ___ \| | | | (_| | | |_) |  __/ | (_) |"
echo " |____/ \__|\__, /___|_|    \__/ /_/   \_\_| |_|\__, | |_.__/ \___|_|\___/ "
echo "            |___/                               |___/                     "
echo -e "         --- Custom Hyprland Environment by Anghelo BR --- \n\e[0m"

# Asegurar permisos de ejecución en los sub-scripts
chmod +x scripts/*.sh

# Ejecutar módulos en orden
./scripts/00-dependencies.sh
./scripts/01-hyprland.sh

echo -e "\n\e[32m[+] ¡Entorno Styx instalado con éxito! Reinicia para aplicar.\e[0m"
