# Nix Setup

## WSL Setup

Install nix:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```

Install home-manager:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

Edit `/etc/nix/nix.conf`:
`experimental-features = nix-command flakes`

Then run `home-manager switch --flake ~/nix#<config_name>`.

### Installing required fonts

Install `CascaydiaCove Nerd Font` and the `Symbols Only` fonts from [nerdfonts.com](https://www.nerdfonts.com/font-downloads).

## NixVim

Official [NixVim](https://nix-community.github.io/nixvim/index.html) Website.

## Davinci Resolve

[Setup Page](https://wiki.nixos.org/wiki/DaVinci_Resolve).

## Secret handling

Secret handling is done via age. More information [here](https://github.com/ryantm/agenix).

## Using home manager with WSL

Run command after updating home manager configuration:

```bash
home-manager --flake .#wsl switch
```

## Configuring Cloudflare tunnels

[Link](https://olai.dev/blog/nix-cloudflare-tunnels/)

## Setup Git

First login using `gh auth login` then in the git repository run `gh auth setup-git`.
