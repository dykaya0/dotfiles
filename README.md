# Dotfiles for Arch + Hyprland 🧭💻

A clean, opinionated set of configurations for Arch Linux with Hyprland. This repo houses the utilities, window manager tweaks, editor setups, and scripts I rely on daily. It’s designed to be approachable for folks with minimal Linux/terminal experience, while still being useful for power users who want ideas to borrow or adapt.

> This is a personal configuration. Adapt it to your hardware, preferences, and security needs.

---

## What’s Included

- Hyprland desktop configurations and startup scripts
  - Per-monitor tweaks, autostart helpers, and look-and-feel tweaks
- Terminal, editor, and shell
  - Neovim (Lua-based config with plugins)
  - Zsh and shell tweaks
  - Powerline-friendly prompts and visuals
- Desktop apps and utilities
  - Rofi launcher, themes, and tweaks
  - Tiling/window-manager helpers and scripts
  - MPV player defaults
  - Qutebrowser bookmarks and config
  - Waybar theming and modules
- Apps configuration
  - Neovim plugins, MPV, Qutebrowser, and other app configs
- Scripting and automation
  - run-scripts and helper scripts for common tasks
  - Bootstrap tools to set up a fresh system
- Package and bootstrap helpers
  - setup/dotfiles-setup.sh to install dependencies and link configs
  - setup/install-tpm.sh for tmux plugin manager (optional)

Folder overview (high level)
- ghostty/  → Personal user space: terminal/GUI tweaks
- hypr/     Hyprland configs, autostart, and rules
- mpv/      MPV player configuration
- nvim/     Neovim setup (Lua, plugins)
- qutebrowser/ Browsing config and bookmarks
- rofi/     Rofi launcher and style
- run-scripts/ Helper scripts for common tasks
- scripts/  Utilities and small tooling
- setup/    Bootstrap scripts and package lists
- run.sh    Top-level bootstrap/launcher helper (if present)

---

## Prerequisites

To use these dotfiles effectively, you’ll want:
- A machine running Arch Linux (or a closely related arch-based distro)
- Basic familiarity with a terminal (commands, navigation, text editing)
- Hyprland (Wayland) as your main desktop shell (optional for exploring ideas)
- Git installed to clone the repo
- A capable font stack for icons/ligatures (e.g., Nerd Fonts, JetBrains Mono with Powerline)

Tools you may install via the setup script:
- A package helper (yay or paru) for AUR packages
- Neovim, Zsh, rofi, Hyprland utilities, and more
- tmux and tmux plugin manager (optional)

If you’re new to Linux, you can rely on the included setup script to install and wire things up for you.

---

## Quick Start (Minimal Knowledge)

If you want a simple path to get going, use the official bootstrap script (recommended):

1) Clone this repo
- Command: `git clone https://github.com/your-username/dotfiles.git ~/dotfiles`

2) Run the setup/bootstrap script to install dependencies and link configs
- Command: `bash ~/dotfiles/setup/dotfiles-setup.sh`

3) Log out and back in (or restart Hyprland) to apply changes
- This allows the new dotfiles to be linked and applied

4) Optional: open Neovim and install plugins if prompted
- Neovim plugins are usually installed automatically or via a built-in command in the setup

If you prefer not to run the setup script, you can manually:
- Install required packages (see setup/packages lists)
- Use a symlink approach (GNU Stow) to link configs into your home
- Ensure shell startup files source the new config

---

## How to Use and Customize

- Each app’s configuration lives in its own folder at the repo root:
  - Hyprland: `hypr/`
  - Neovim: `nvim/`
  - Qutebrowser: `qutebrowser/`
  - MPV: `mpv/`
  - Rofi: `rofi/`
  - And helper scripts in `scripts/`, `run-scripts/`, and `setup/`

- How configs are applied:
  - The project is designed to be linked into your home directory (commonly via GNU Stow) so your actual dotfiles appear under:
    - `~/.config/ghostty/config`
    - `~/.config/hypr/` and related Hyprland files
    - `~/.config/nvim/`
    - `~/.config/qutebrowser/`
    - `~/.config/mpv/`
    - `~/.config/rofi/`
  - If you prefer not to use symlinks, you can copy the files directly; the setup script provides an automated linking path.

- Quick customization ideas:
  - Hyprland: edit `hypr/configs/` for appearance and behavior per monitor
  - Neovim: edit `nvim/init.lua` and `nvim/lua/` modules
  - Waybar: tweak `waybar/config.jsonc` and `waybar/style/` themes
  - Browser shortcuts and bookmarks in `qutebrowser/`

- Reverting:
  - The repo is the single source of truth; re-run the setup script to re-link your home configs.

---

## Folder Structure (Details)

- ghostty/  — Personal UI tweaks and config options
- hypr/     — Hyprland configs, autostart, input rules, look-and-feel
- mpv/      — MPV defaults and behavior
- nvim/     — Neovim config (Lua-based, plugins)
- qutebrowser/ — Browser-specific settings and bookmarks
- rofi/     — Rofi themes and launcher setup
- run-scripts/ — Convenience scripts for common tasks
- scripts/  — Small utilities and helpers
- setup/    — Bootstrap scripts and package lists
- run.sh     — Top-level bootstrap/launcher (if present)

---

## Updating and Maintenance

- To refresh:
  - `git pull origin main` (or your current branch)
  - Re-run: `bash setup/dotfiles-setup.sh` to apply changes consistently
- If you customize locally, note changes to avoid merge conflicts when updating.

Tips:
- Back up important personal files before major changes.
- If an app breaks, check its folder in this repo for updates.

---

## Troubleshooting (Common Scenarios)

- Nothing applies to your home: ensure you ran the setup script or linking steps
- Font icons look broken: install patched Powerline/Nerd fonts and restart
- Hyprland not starting: ensure Wayland dependencies are installed; verify `hyprland.conf`
- Neovim plugins not loading: ensure plugin manager is installed and run plugin install

If you’re stuck, share error messages or logs and I’ll help diagnose.

---

## Contributing

- This is a personal dotfiles repo for learning and own use.
- If you’d like to contribute ideas, improvements to documentation, or more modular configurations, I’m open to it.
- Please keep changes aligned with the repo’s structure and test locally before proposing.

---

## License

This is a personal configuration repository. There may not be a public license file included. Use it as a reference for your own setup and adapt as needed. If you publish or share, consider adding a license and clearly stating terms.

---

If you’d like, I can tailor this README further to reflect exact installation steps or add a getting-started checklist. Tell me your preferred tone and any details you want highlighted.