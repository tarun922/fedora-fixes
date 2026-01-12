#!/bin/bash

# --- COLORS ---
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color
BOLD='\033[1m'

# --- HELPER FUNCTIONS ---
type_out() {
    local text="$1"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        sleep 0.01
    done
    echo ""
}

# --- MENU LOOP ---
while true; do
    clear
    echo -e "${RED}"
    cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|

    >> EMERGENCY SYSTEM OVERRIDE CONSOLE v2.0 <<
EOF
    echo -e "${NC}"

    echo -e "${RED}${BOLD}  [!] WARNING: USE AT YOUR OWN RISK. SYSTEM MODIFICATION DETECTED.${NC}"
    echo -e "${CYAN}  --------------------------------------------------------------${NC}"
    
    # Grid Menu Layout
    echo -e "  ${YELLOW}1)${NC} Fix Audio         ${YELLOW}6)${NC} Fix Nvidia Drivers"
    echo -e "  ${YELLOW}2)${NC} Fix Battery       ${YELLOW}7)${NC} Fix Screen Share"
    echo -e "  ${YELLOW}3)${NC} Fix Display       ${YELLOW}8)${NC} System Refresh"
    echo -e "  ${YELLOW}4)${NC} Fix Flatpak       ${YELLOW}9)${NC} Fix Update (DNF)"
    echo -e "  ${YELLOW}5)${NC} Fix Input Lag     ${YELLOW}10)${NC} Fix Bluetooth"
    echo -e "  ${YELLOW}11)${NC} Fix WiFi         ${YELLOW}0)${NC} ABORT MISSION"
    echo -e "${CYAN}  --------------------------------------------------------------${NC}"
    
    echo -ne "${PURPLE}${BOLD}  ┌──(hacker@fedora)-[~/fedora-fixes]\n  └─$ ${NC}"
    read choice

    case $choice in
        1)  bash ./Audio-Fix.sh ;;
        2)  bash ./Battery-Fix.sh ;;
        3)  bash ./Display-Fix.sh ;;
        4)  bash ./Flatpak-Fix.sh ;;
        5)  bash ./Input-Fix.sh ;;
        6)  bash ./Nvidia-Fix.sh ;;
        7)  bash ./Share-Fix.sh ;;
        8)  bash ./System-Refresh.sh ;;
        9)  bash ./Update-Fix.sh ;;
        10) bash ./fix-bluetooth.sh ;;
        11) bash ./fix-wifi.sh ;;
        0)  type_out "${RED}Cleaning logs and exiting...${NC}"; sleep 1; clear; exit 0 ;;
        *)  echo -e "${RED}Invalid Protocol.${NC}"; sleep 1 ;;
    esac

    echo -e "\n${GREEN}  Protocol execution finished.${NC}"
    echo -e "  Press [ENTER] to return to console..."
    read
done
