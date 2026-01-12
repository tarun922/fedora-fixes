#!/bin/bash

# --- STYLING ---
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Typewriter effect function
type_out() {
    local text="$1"
    local delay=0.03
    for (( i=0; i<${#text}; i++ )); do
        echo -ne "${text:$i:1}"
        sleep $delay
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

    >> FEDORA BLUETOOTH EMERGENCY RECOVERY TOOL <<
EOF
echo -e "${NC}"

# --- EXECUTION ---
type_out "${CYAN}[*] Initializing system-wide Bluetooth override...${NC}"
sleep 1

# 1. Unblock Radios
type_out "${YELLOW}[>] Forcing RFKILL unblock on all radios...${NC}"
sudo rfkill unblock bluetooth
sudo rfkill unblock all

# 2. Restart Bluetooth Service
type_out "${YELLOW}[>] Killing and restarting bluetooth.service...${NC}"
sudo systemctl restart bluetooth

# 3. Kernel Module Reload
type_out "${YELLOW}[>] Reloading BTUSB kernel modules...${NC}"
sudo rmmod btusb 2>/dev/null
sleep 1
sudo modprobe btusb

# 4. Audio Stack Sync
type_out "${YELLOW}[>] Refreshing Pipewire & Wireplumber sessions...${NC}"
systemctl --user restart pipewire wireplumber

# 5. Controller Power Reset
type_out "${YELLOW}[>] Cycling controller power via bluetoothctl...${NC}"
bluetoothctl power off >/dev/null 2>&1
sleep 1
bluetoothctl power on >/dev/null 2>&1

echo -e "\n${GREEN}=============================================="
type_out "      [SUCCESS] PROTOCOL COMPLETE."
type_out "      YOUR BLUETOOTH IS NOW STABILIZED."
echo -e "==============================================${NC}"
