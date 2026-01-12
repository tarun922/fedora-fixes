#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${RED}HORROR-TI >> AUDIO RECOVERY MODE${NC}"

echo -e "${CYAN}[*] Killing stale Pipewire processes...${NC}"
systemctl --user stop pipewire pipewire-pulse wireplumber

echo -e "${CYAN}[*] Clearing Pipewire state...${NC}"
rm -rf ~/.config/pulse
rm -rf ~/.local/state/wireplumber

echo -e "${CYAN}[*] Restarting Audio Engines...${NC}"
systemctl --user start pipewire pipewire-pulse wireplumber

echo -e "${RED}[!] If sound is still missing, check 'pavucontrol' output devices.${NC}"
