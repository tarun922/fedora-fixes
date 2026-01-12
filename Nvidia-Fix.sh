
#!/bin/bash
RED='\033[0;31m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; NC='\033[0m'
clear; echo -e "${RED}"
cat << "EOF"
  _    _  ____  _____  _____   ____  _____        _______ _____ 
 | |  | |/ __ \|  __ \|  __ \ / __ \|  __ \      |__   __|_   _|
 | |__| | |  | | |__) | |__) | |  | | |__) |________| |    | |  
 |  __  | |  | |  _  /|  _  /| |  | |  _  /|________| |    | |  
 | |  | | |__| | | \ \| | \ \| |__| | | \ \         | |   _| |_ 
 |_|  |_|\____/|_|  \_\_|  \_\\____/|_|  \_\        |_|  |_____|
    >> NVIDIA KERNEL MODULE FORCED REBUILD <<
EOF
echo -e "${NC}"
echo -e "${CYAN}[*] Forcing akmod to recompile Nvidia drivers...${NC}"
sudo akmods --force
echo -e "${CYAN}[*] Updating initramfs image...${NC}"
sudo dracut -f
echo -e "${YELLOW}[!] REBOOT REQUIRED to apply new kernel modules.${NC}"
