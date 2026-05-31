# Prachi's Dotfiles

My personal configuration files for Omarchy (Arch Linux + Hyprland).

## What's Managed

| Config | Location | Description |
|--------|----------|-------------|
| `git` | `~/.config/git/config` | Git aliases, user info, diff settings |
| `starship` | `~/.config/starship.toml` | Terminal prompt theme |
| `ghostty` | `~/.config/ghostty/config` | Terminal emulator settings |
| `tmux` | `~/.config/tmux/tmux.conf` | Terminal multiplexer |
| `lazygit` | `~/.config/lazygit/config.yml` | Git TUI (terminal UI) |

## Quick Start (New Machine)

```bash
# 1. Clone this repo
git clone git@github.com:prachi-keshavani/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run the install script
bash install.sh
```

## How Symlinks Work

These config files live in `~/dotfiles/` and are **symlinked** to their actual locations.

```
~/dotfiles/.config/starship.toml  ←──  real file
        │
        └── symlink ──→  ~/.config/starship.toml
```

When you edit `~/.config/starship.toml`, you're actually editing the file in `~/dotfiles/`. This means:
- All changes are tracked by git
- Easy to backup and restore
- One place to manage everything

## Adding a New Config

```bash
# 1. Move the config into dotfiles
mv ~/.config/some-app/config ~/dotfiles/.config/some-app/config

# 2. Create a symlink
ln -s ~/dotfiles/.config/some-app/config ~/.config/some-app/config

# 3. Commit
git add .config/some-app/
git commit -m "Add some-app config"
```

## Reference

See `~/dotfiles-reference/` for configs from another machine (kept for ideas).
