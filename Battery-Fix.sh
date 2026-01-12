#!/bin/bash
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

clear
echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|

    >> POWER DRAIN & THERMAL OPTIMIZER <<
EOF
echo -e "${NC}"

echo -e "${CYAN}[*] Scaling CPU frequency for efficiency...${NC}"
sudo cpupower frequency-set -g powersave 2>/dev/null

echo -e "${CYAN}[*] Killing background power-hungry services...${NC}"
sudo rfkill block wwan 2>/dev/null # Kill mobile data if not used

echo -e "${CYAN}[*] Enabling Auto-Suspend for idle USB devices...${NC}"
for i in /sys/bus/usb/devices/*/power/control; do echo auto | sudo tee $i >/dev/null; done

echo -e "${YELLOW}[!] Battery life extended. Thermal throttling active.${NC}"
