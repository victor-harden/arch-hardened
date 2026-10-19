<div align="center">

# 🛡️ Arch Linux Hardened

**Production-oriented Arch Linux hardening framework**

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?logo=arch-linux&logoColor=white)](https://archlinux.org/)

</div>

---

## Overview

This repository contains a carefully curated set of configurations and scripts designed to significantly improve the security posture of an Arch Linux desktop or workstation while remaining usable for daily work.

It is **not** a "set and forget" script. It is meant to be reviewed, understood, and adapted.

## Core Principles

- Minimize attack surface
- Prefer auditable solutions over black boxes
- Full disk encryption by default
- Strong process isolation
- Easy rollback via Btrfs snapshots

## Features

| Category              | Implementation                          |
|-----------------------|-----------------------------------------|
| Disk Encryption       | LUKS2                                   |
| Boot Security         | Secure Boot + Unified Kernel Images     |
| Filesystem            | Btrfs + Snapper                         |
| Firewall              | nftables (default drop)                 |
| MAC                   | AppArmor                                |
| Sandboxing            | Firejail                                |
| Kernel                | Hardened sysctl + optional zen/hardened |
| Services              | Aggressive service minimization         |

## Structure

```text
arch-hardened/
├── configs/
│   ├── nftables.conf
│   ├── sysctl.d/
│   └── apparmor/
├── scripts/
│   ├── harden.sh
│   ├── setup-luks.sh
│   └── check-hardening.sh
└── docs/
    └── hardening-philosophy.md
```

## Quick Start

```bash
git clone https://github.com/blackhat264/arch-hardened.git
cd arch-hardened

# Always review before running
less scripts/harden.sh
sudo ./scripts/harden.sh
```

## Warning

These settings are relatively aggressive. Some applications may require additional AppArmor profiles or Firejail exceptions. Test thoroughly before deploying on a primary machine.

## License

MIT
