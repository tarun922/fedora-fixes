#!/bin/bash
RED='\033[0;31m'; GREEN='\033[0;32m'; CYAN='\033[0;36m'; NC='\033[0m'
type_out() { local text="$1"; for (( i=0; i<${#text}; i++ )); do echo -ne "${text:$i:1}"; sleep 0.02; done; echo ""; }
clear; echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|
    >> FLATPAK CORRUPTION REPAIR PROTOCOL <<
EOF
echo -e "${NC}"
type_out "${CYAN}[*] Patching Flatpak runtime environment...${NC}"
sudo flatpak repair
type_out "${CYAN}[*] Fixing SELinux permissions for system-helper...${NC}"
sudo restorecon -v /usr/libexec/flatpak-system-helper
type_out "${CYAN}[*] Clearing stale Flatpak metadata...${NC}"
flatpak uninstall --unused -y
echo -e "\n${GREEN}[SUCCESS] FLATPAK ECOSYSTEM STABILIZED.${NC}"
