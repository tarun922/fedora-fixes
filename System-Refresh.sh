#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____   
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \  
 | |__| | |  | | |__) | |__) | |  | | |__) | 
 |  __  | |  | |  _  /|  _  /| |  | |  _  /  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \  
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\ 

    >> SYSTEM OPTIMIZATION & PURGE <<
EOF
echo -e "${NC}"

echo -e "${CYAN}[*] Initiating System Cleanup...${NC}"
# Clear DNF Cache
sudo dnf clean all
# Trim SSD (Good for performance)
sudo fstrim -av
# Vacuum Journal Logs (Keep last 2 days only)
sudo journalctl --vacuum-time=2d
# Refresh Font Cache
fc-cache -f -v >/dev/null 2>&1

echo -e "${GREEN}[+] System Lean and Mean.${NC}"
