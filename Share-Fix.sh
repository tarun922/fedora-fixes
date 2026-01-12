#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
clear; echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|
    >> WAYLAND SCREEN-SHARE RECOVERY <<
EOF
echo -e "${NC}"
echo -e "${CYAN}[*] Killing stale portal processes...${NC}"
killall -9 xdg-desktop-portal-kde xdg-desktop-portal
sleep 1
echo -e "${CYAN}[*] Manually re-spawning Wayland Portal...${NC}"
/usr/libexec/xdg-desktop-portal-kde & >/dev/null 2>&1
/usr/libexec/xdg-desktop-portal & >/dev/null 2>&1
echo -e "\n${GREEN}[SUCCESS] SCREENCASTING PORTALS RESET.${NC}"
