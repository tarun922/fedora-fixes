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

    >> DISPLAY COMPOSITOR & SHELL REFRESH <<
EOF
echo -e "${NC}"

type_out "${CYAN}[*] Detecting GUI inconsistencies... Injecting fix...${NC}"
sleep 1

type_out "${YELLOW}[>] Resetting KWin Window Manager...${NC}"
# This works for Wayland (Fedora default)
(kwin_wayland --replace &) >/dev/null 2>&1
sleep 2

type_out "${YELLOW}[>] Killing corrupted Plasma Shell...${NC}"
kquitapp6 plasmashell || killall plasmashell 2>/dev/null
sleep 1

type_out "${YELLOW}[>] Re-spawning clean Shell environment...${NC}"
(kstart6 plasmashell &) >/dev/null 2>&1

echo -e "\n${GREEN}=============================================="
type_out "      [SUCCESS] GUI PIPELINE RECONSTRUCTED."
echo -e "==============================================${NC}"
