# 🛡️ Arch Linux Hardened

Full Arch Linux hardening setup focused on desktop security.

## Features

- **Full Disk Encryption** with LUKS2
- **Secure Boot** (without Microsoft keys when possible)
- **Btrfs** with Snapper for snapshots & rollback
- **nftables** firewall (drop by default)
- **AppArmor** + **Firejail** for application confinement
- Hardened kernel options
- Minimal attack surface

## Structure

```
arch-hardened/
├── configs/
│   ├── nftables.conf
│   ├── apparmor/
│   └── sysctl.d/
├── scripts/
│   ├── harden.sh
│   ├── setup-luks.sh
│   └── check-hardening.sh
└── docs/
    └── hardening-checklist.md
```

## Quick Start

```bash
# Clone
git clone https://github.com/blackhat264/arch-hardened.git
cd arch-hardened

# Review and run hardening script (as root)
sudo ./scripts/harden.sh
```

## Warning

These configurations are aggressive. Test on a VM first. Some applications may break under strict AppArmor/Firejail profiles.

## License

MIT
