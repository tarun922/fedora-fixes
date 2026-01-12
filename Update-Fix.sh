#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

type_out() {
    local text="$1"
    for (( i=0; i<${#text}; i++ )); do echo -ne "${text:$i:1}"; sleep 0.02; done
    echo ""
}

clear
echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|

    >> DNF PACKAGE MANAGER EMERGENCY REPAIR <<
EOF
echo -e "${NC}"

type_out "${CYAN}[*] Searching for stuck package locks...${NC}"
sudo rm -f /var/lib/dnf/metadata_lock.pid 2>/dev/null

type_out "${YELLOW}[>] Rebuilding RPM Database (Standby)...${NC}"
sudo rpm --rebuilddb

type_out "${YELLOW}[>] Clearing corrupted metadata...${NC}"
sudo dnf clean all

type_out "${YELLOW}[>] Synchronizing repositories...${NC}"
sudo dnf makecache

echo -e "\n${GREEN}[SUCCESS] PACKAGE MANAGER IS BACK ONLINE.${NC}"
