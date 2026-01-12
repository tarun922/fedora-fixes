# 💀 HORROR-TI: Fedora Emergency Fixer Suite

![Fedora](https://img.shields.io/badge/Fedora-41%2F42%2F43-blue?style=for-the-badge&logo=fedora)
![Shell Script](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-red.svg?style=for-the-badge)

**HORROR-TI** is an aggressive system recovery toolkit for Fedora Linux. It is designed to "brute-force" fixes for common hardware and software glitches by cycling kernel modules, purging stale caches, and resetting system daemons.

---

## ⚡ The Arsenal

This suite contains specialized override protocols for the most common Fedora frustrations:

| Script | Protocol Description |
| :--- | :--- |
| **`main.sh`** | 🕹️ **The Master Console** (Launch this for the hacker-view menu) |
| `Audio-Fix.sh` | Restores "Dummy Output" by nuking stale Pipewire states |
| `Battery-Fix.sh` | Disables power-hungry polling and optimizes thermal scaling |
| `Display-Fix.sh` | Restarts KWin and Plasma Shell without closing active windows |
| `Flatpak-Fix.sh` | Repairs Flatpak DB and fixes SELinux permission contexts |
| `Input-Fix.sh` | Reloads HID and PS/2 modules to cure mouse/touchpad lag |
| `Nvidia-Fix.sh` | Forces a manual `akmods` rebuild for GPU driver failure |
| `Share-Fix.sh` | Kicks Wayland portals back to life for screen-sharing stability |
| `System-Refresh.sh` | Vacuums journal logs and trims SSD for maximum performance |
| `Update-Fix.sh` | Breaks DNF metadata locks and rebuilds the RPM database |
| `fix-bluetooth.sh` | Resets the Bluetooth stack and cycles the `btusb` module |
| `fix-wifi.sh` | Flushes DNS, clears RFKILL locks, and reloads WiFi drivers |

---

## 🚀 Quick Deployment

Clone the repository and enter the terminal:

```bash
git clone [https://github.com/tarun922/fedora-fixes.git](https://github.com/tarun922/fedora-fixes.git)
cd fedora-fixes
chmod +x *.sh

```
# Launching the Override Console:
```bash
./main.sh
```
# 📸 Aesthetic
```
Every script features a massive HORROR-TI ASCII banner, typewriter-style status updates, and a Kali-inspired interface. It doesn't just fix your OS; it makes it look like you're overriding the mainframe.
```
# ⚠️ Protocol Warning
[!] USE AT YOUR OWN RISK. These scripts execute sudo commands to reload kernel modules and system-level services. It is highly recommended to save all work before running a protocol, as some fixes (like Nvidia or Display) may refresh your session.

# 🤝 Contributing
Found a new bug? Submit a Pull Request with your custom fix.
# Maintained by tarun922
