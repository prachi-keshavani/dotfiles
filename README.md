# Prachi's Dotfiles

My personal configuration files for Omarchy (Arch Linux + Hyprland).

## Folder Structure (Stow-Compatible)

```
dotfiles/
├── home/                    ← Everything here mirrors ~/ on your machine
│   ├── .agents/
│   │   └── skills/          ← AI coding agent skills
│   ├── .config/
│   │   ├── git/config
│   │   ├── git/ignore
│   │   ├── ghostty/config
│   │   ├── lazygit/config.yml
│   │   ├── tmux/tmux.conf
│   │   └── starship.toml
│   └── .gitconfig
├── install.sh               ← Manual symlink script
└── README.md
```

### Why `home/`?

This structure follows the **GNU Stow convention**.

**Stow** is a symlink manager. If you ran:
```bash
cd ~/dotfiles && stow home
```

It would automatically create symlinks from `~/` to every file inside `home/`, preserving the directory structure. We do the same thing manually with `install.sh` for full control.

Think of it as:
- `home/` = a template of your home directory
- `install.sh` = copies that template into place using symlinks

## What's Managed

| Config | Location | Description |
|--------|----------|-------------|
| `git` | `~/.config/git/config` | Git aliases, user info, delta pager |
| `git/ignore` | `~/.config/git/ignore` | Global git ignore rules |
| `.gitconfig` | `~/.gitconfig` | Git delta diff settings |
| `starship` | `~/.config/starship.toml` | Terminal prompt theme |
| `ghostty` | `~/.config/ghostty/config` | Terminal emulator settings |
| `tmux` | `~/.config/tmux/tmux.conf` | Terminal multiplexer |
| `lazygit` | `~/.config/lazygit/config.yml` | Git TUI (terminal UI) |
| `agents/skills` | `~/.agents/skills` | AI coding agent skills |

## Quick Start (New Machine)

```bash
# 1. Clone this repo
git clone git@github.com:prachi-keshavani/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 2. Run the install script (creates symlinks)
bash install.sh
```

## How Symlinks Work

These config files live in `~/dotfiles/home/` and are **symlinked** to their actual locations in `~/`.

```
~/dotfiles/home/.config/starship.toml  ←── real file
        │
        └── symlink ──→  ~/.config/starship.toml
```

When you edit `~/.config/starship.toml`, you're actually editing the file in `~/dotfiles/home/`. This means:
- All changes are tracked by git
- Easy to backup and restore
- One place to manage everything

## Adding a New Config

```bash
# 1. Move the config into dotfiles/home/
mv ~/.config/some-app/config ~/dotfiles/home/.config/some-app/config

# 2. Create a symlink
ln -s ~/dotfiles/home/.config/some-app/config ~/.config/some-app/config

# 3. Commit
cd ~/dotfiles
git add home/.config/some-app/
git commit -m "Add some-app config"
```

## Reference

See `~/dotfiles-reference/` for configs from another machine (kept for ideas).
