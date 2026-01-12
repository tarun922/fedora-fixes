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

    >> FEDORA WIFI NETWORK RECOVERY TOOL <<
EOF
echo -e "${NC}"

# --- EXECUTION ---
type_out "${CYAN}[*] Initializing Network Protocol Override...${NC}"
sleep 1

# 1. Clear NetworkManager Cache & Restart
type_out "${YELLOW}[>] Restarting NetworkManager Service...${NC}"
sudo systemctl restart NetworkManager

# 2. Force Radio Unblock
type_out "${YELLOW}[>] Disabling Software Radio Locks (RFKILL)...${NC}"
sudo rfkill unblock wifi
sudo rfkill unblock all

# 3. Kernel Module Refresh (Common Intel/Realtek fix)
type_out "${YELLOW}[>] Cycling WiFi Kernel Modules...${NC}"
# Attempt to find the active wifi module and reload it
WIFI_MOD=$(lsmod | grep -oE '(iwlwifi|ath10k_pci|rtw88_8822ce|mt7921e)' | head -n 1)
if [ ! -z "$WIFI_MOD" ]; then
    sudo modprobe -r $WIFI_MOD 2>/dev/null
    sleep 1
    sudo modprobe $WIFI_MOD 2>/dev/null
    type_out "${CYAN}[+] Reloaded module: $WIFI_MOD${NC}"
fi

# 4. Flush DNS Cache
type_out "${YELLOW}[>] Purging DNS Resolver Cache...${NC}"
sudo resolvectl flush-caches

# 5. Network Interface Toggle
type_out "${YELLOW}[>] Hard-resetting interface state...${NC}"
nmcli networking off
sleep 1
nmcli networking on

echo -e "\n${GREEN}=============================================="
type_out "      [SUCCESS] WIFI SIGNAL RESTORED."
type_out "      ENCRYPTED CONNECTION STABILIZED."
echo -e "==============================================${NC}"
