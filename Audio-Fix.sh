#!/bin/bash

# --- STYLING ---
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' 

type_out() {
    local text="$1"
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        sleep 0.03
    done
    echo ""
}

clear

# --- BANNER ---
echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|

    >> SOUND ENGINE RECOVERY & BUFFER PURGE <<
EOF
echo -e "${NC}"

type_out "${CYAN}[*] Vulnerability found in Pipewire stack... Overriding...${NC}"
sleep 1

type_out "${YELLOW}[>] Terminating audio daemons...${NC}"
systemctl --user stop pipewire pipewire-pulse wireplumber 2>/dev/null

type_out "${YELLOW}[>] Wiping stale state & cache files...${NC}"
rm -rf ~/.config/pulse
rm -rf ~/.local/state/wireplumber
sleep 1

type_out "${YELLOW}[>] Force-restarting Pipewire engine...${NC}"
systemctl --user start pipewire pipewire-pulse wireplumber

echo -e "\n${GREEN}=============================================="
type_out "      [SUCCESS] AUDIO FREQUENCIES RESTORED."
echo -e "==============================================${NC}"
