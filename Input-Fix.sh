#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
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

    >> HID DRIVER & INPUT STACK RECOVERY <<
EOF
echo -e "${NC}"

echo -e "${CYAN}[*] Reloading PS/2 and I2C Touchpad modules...${NC}"
sudo modprobe -r psmouse && sudo modprobe psmouse
sudo modprobe -r i2c_hid_acpi && sudo modprobe i2c_hid_acpi 2>/dev/null

echo -e "${CYAN}[*] Restarting Libinput...${NC}"
sudo systemctl restart systemd-logind

echo -e "\n${GREEN}[SUCCESS] INPUT LAG PURGED. CONTROL RESTORED.${NC}"
