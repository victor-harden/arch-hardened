#!/bin/bash
# Arch Linux Hardening Script
# Run as root

set -euo pipefail

echo "[+] Starting Arch Linux hardening..."

# Update system
pacman -Syu --noconfirm

# Install security packages
pacman -S --noconfirm nftables apparmor firejail fail2ban rkhunter clamav

# Enable services
systemctl enable --now nftables
systemctl enable --now apparmor
systemctl enable --now fail2ban

# Basic sysctl hardening
cat > /etc/sysctl.d/99-hardening.conf << EOF
kernel.kptr_restrict = 2
kernel.dmesg_restrict = 1
kernel.unprivileged_bpf_disabled = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
EOF

sysctl --system

echo "[+] Hardening applied. Reboot recommended."
