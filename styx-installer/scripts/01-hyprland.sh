#!/usr/bin/env bash

GREEN="\e[32m"
PURPLE="\e[35m"
ENDCOLOR="\e[0m"

msg() {
    echo -e "${PURPLE}[Styx-Core]${ENDCOLOR} ${GREEN}$1${ENDCOLOR}"
}

msg "Instalando Hyprland y componentes de video..."
sudo pacman -S --noconfirm hyprland xdg-desktop-portal-hyprland qt5-wayland qt6-wayland

msg "Instalando la interfaz (Waybar, Rofi-Wayland, SWWW y utilitarios)..."
# Espacio corregido aquí entre swww, grim y lo demás
sudo pacman -S --noconfirm waybar rofi-wayland swww grim slurp wl-clipboard cliphist brightnessctl

msg "Asegurando aplicaciones del usuario (Ghostty y Thunar)..."
sudo pacman -S --noconfirm ghostty thunar thunar-archive-plugin

# -----------------------------------------------------------------------------
# 🚀 INYECTANDO CONFIGURACIÓN NATIVA STYX x ANGHELO BR
# -----------------------------------------------------------------------------
msg "Creando directorios de configuración..."
mkdir -p ~/.config/hypr

msg "Escribiendo hyprland.conf con tus atajos personalizados..."
cat << 'EOF' > ~/.config/hypr/hyprland.conf
# =============================================================================
# 🔑 STYX x ANGHELO BR - CONFIGURACIÓN CORE & BINDINGS
# =============================================================================

# Definir la tecla Super (Mod4)
$mainMod = SUPER

# --- MONITORES ---
monitor=,highrr,auto,1

# --- INPUT ---
input {
    kb_layout = es
    follow_mouse = 1
}

# --- ESTÉTICA BASE ---
general {
    gaps_in = 6
    gaps_out = 12
    border_size = 2
    col.active_border = rgba(cba6f7ff) rgba(89b4faff) 45deg
    col.inactive_border = rgba(595959aa)
    layout = dwindle
}

decoration {
    rounding = 12
    blur {
        enabled = true
        size = 6
        passes = 3
    }
}

# -----------------------------------------------------------------------------
# 🎹 TU MEMORIA MUSCULAR TRADUCIDA (De sxhkd a Hyprland)
# -----------------------------------------------------------------------------
bind = $mainMod, Return, exec, ghostty
bind = $mainMod, e, exec, thunar
bind = $mainMod, b, exec, firefox
bind = $mainMod, n, exec, ghostty -e nvim
bind = $mainMod, d, exec, rofi -show drun -show-icons

# Capturas de pantalla rápidas estilo Flameshot
bind = , Print, exec, grim -g "$(slurp)" - | wl-copy && wl-paste > ~/Imágenes/Screenshot_$(date +%F_%T).png

# Historial del Portapapeles (Cliphist)
bind = $mainMod, v, exec, cliphist list | rofi -dmenu -p "Portapapeles" | cliphist decode | wl-copy

# Gestión de ventanas flotantes y cerrar activo
bind = $mainMod SHIFT, w, killactive,
bind = $mainMod, m, togglefloating,
bind = $mainMod, f, fullscreen, 1
bind = $mainMod SHIFT, f, fullscreen, 0

# Enfoque de ventanas (hjkl estilo bspwm)
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

# Intercambiar ventanas (bspwm swap)
bind = $mainMod SHIFT, h, swapwindow, l
bind = $mainMod SHIFT, l, swapwindow, r
bind = $mainMod SHIFT, k, swapwindow, u
bind = $mainMod SHIFT, j, swapwindow, d

# Navegación por escritorios (Workspaces)
bind = $mainMod, bracketleft, workspace, e-1
bind = $mainMod, bracketright, workspace, e+1

bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Mover ventanas a escritorios de forma silenciosa
bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10

# Redimensionar ventanas activas (Alt + hjkl)
binde = $mainMod ALT, l, resizeactive, 20 0
binde = $mainMod ALT, h, resizeactive, -20 0
binde = $mainMod ALT, k, resizeactive, 0 -20
binde = $mainMod ALT, j, resizeactive, 0 20

# Mover con el Mouse
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# Teclas multimedia Lenovo IdeaPad
bindel = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
bindl = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle
bindel = , XF86MonBrightnessDown, exec, brightnessctl set 5%-
bindel = , XF86MonBrightnessUp, exec, brightnessctl set +5%
bindl = , XF86WLAN, exec, rfkill toggle all
bindl = $mainMod, x, exec, hyprlock
EOF

msg "¡Archivo hyprland.conf generado exitosamente!"
