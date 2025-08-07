# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive NixOS configuration management repository using flakes, organized for both standalone home-manager and NixOS system configurations. It supports multiple machine types including WSL environments, laptops, and servers with homelab services.

## Architecture

### Flake Structure
- **flake.nix**: Main entry point defining inputs (nixpkgs, home-manager, nixvim, stylix, agenix)
- **nixosConfigurations**: Full NixOS systems (laptop, bosch_vm, vm with homelab)  
- **homeConfigurations**: Standalone home-manager configs (wsl_bosch, wsl_home)

### Directory Organization
- **home-manager/**: User-level configurations
  - **dots/**: Application dotfiles (nixvim, hyprland, tmux, git, etc.)
  - **machines/**: Machine-specific home-manager configurations
- **machines/**: NixOS system configurations with hardware configs
- **homelab/**: Server services (jellyfin, technitium, samba, cloudflared)
- **users/**: User definitions
- **modules/**: Shared nixos modules (tailscale)

### Configuration Patterns
- Machine-specific configs import from shared `dots/` modules
- WSL configs are minimal (zsh, git, tmux, nixvim, btop)
- Full desktop configs include Hyprland, GNOME, and development tools
- Secrets managed via agenix encryption
- Custom nixvim configuration with web development and copilot features

## Common Commands

### Home Manager (WSL/Standalone)
```bash
# Switch to WSL configuration
home-manager switch --flake .#wsl_home
home-manager switch --flake .#wsl_bosch

# Build without switching
home-manager build --flake .#wsl_home
```

### NixOS Systems
```bash
# Rebuild system configuration
sudo nixos-rebuild switch --flake .#laptop
sudo nixos-rebuild switch --flake .#vm
sudo nixos-rebuild switch --flake .#bosch_vm

# Build without switching
sudo nixos-rebuild build --flake .#laptop
```

### Development Workflow
```bash
# Update all flake inputs
nix flake update

# Check flake
nix flake check

# Show flake outputs
nix flake show

# Enter development shell
nix develop

# Manage secrets
agenix -e secrets/example.age
```

### Initial Setup Commands
```bash
# WSL setup (from README)
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon

# Add experimental features to /etc/nix/nix.conf
experimental-features = nix-command flakes

# Git authentication setup
gh auth login
gh auth setup-git
```

## Key Configuration Points

### User Management
- Default user: `grop` (flake.nix:32)
- WSL user: `gpa9bh` 
- Machine-specific user overrides in individual configs

### Development Environment
- NixVim with web development and copilot features enabled
- Development tools included: git, tmux, lazygit, claude-code
- Shell environment: zsh with custom configuration

### Secrets
- Managed via agenix (machines/_common/secrets/)
- Encrypted files: cloudflared.age, samba.age, tailscaleAuthKey.age, userHashedPassword.age

### Desktop Environment
- Hyprland compositor with waybar, wofi, swaync
- Stylix theming system
- GNOME support for laptop configuration
- Ghostty terminal emulator

### Services (Homelab)
- Cloudflare tunnels for external access
- Jellyfin media server  
- Technitium DNS server
- Samba file sharing
- All services configured in homelab/ directory

## Machine Types

- **wsl_home/wsl_bosch**: Minimal WSL environments
- **laptop**: Full desktop with Hyprland/GNOME
- **vm**: Server with homelab services
- **bosch_vm**: Corporate VM environment