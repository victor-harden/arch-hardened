#!/bin/bash
# ============================================================
# Arch Linux Hardening Script
# Author: blackhat264
# Description: Applies a baseline security hardening for Arch
# ============================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}[!] This script must be run as root${NC}"
    exit 1
fi

echo -e "${GREEN}[+] Starting Arch Linux hardening...${NC}"

# ----------------------------------------------------------
# 1. System update
# ----------------------------------------------------------
echo "[*] Updating system..."
pacman -Syu --noconfirm

# ----------------------------------------------------------
# 2. Install core security packages
# ----------------------------------------------------------
echo "[*] Installing security packages..."
pacman -S --noconfirm --needed \
    nftables \
    apparmor \
    firejail \
    fail2ban \
    rkhunter \
    clamav \
    lynis

# ----------------------------------------------------------
# 3. Enable services
# ----------------------------------------------------------
echo "[*] Enabling services..."
systemctl enable --now nftables
systemctl enable --now apparmor
systemctl enable --now fail2ban

# ----------------------------------------------------------
# 4. Kernel hardening (sysctl)
# ----------------------------------------------------------
echo "[*] Applying sysctl hardening..."
cat > /etc/sysctl.d/99-arch-hardened.conf << 'EOF'
# Kernel pointer restriction
kernel.kptr_restrict = 2

# Restrict dmesg
kernel.dmesg_restrict = 1

# Disable unprivileged BPF
kernel.unprivileged_bpf_disabled = 1

# Network hardening
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.send_redirects = 0
EOF

sysctl --system

echo -e "${GREEN}[+] Hardening baseline applied successfully.${NC}"
echo "[!] Reboot recommended."
