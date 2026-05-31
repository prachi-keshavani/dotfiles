#!/bin/bash
# Dotfiles install script
# Run this on a new machine to create all symlinks
#
# This mimics what GNU Stow does, but manually:
#   cd ~/dotfiles && stow home
# would create the same symlinks automatically.

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
HOMEDIR="$DOTFILES_DIR/home"

echo "🔗 Setting up dotfiles from: $DOTFILES_DIR"
echo "   (mimicking: cd ~/dotfiles && stow home)"

# Create symlinks
link_file() {
    local src="$1"
    local dst="$2"

    # Backup existing file if it exists and is not a symlink
    if [ -f "$dst" ] && [ ! -L "$dst" ]; then
        echo "  📦 Backing up existing: $dst"
        cp "$dst" "$dst.backup.$(date +%s)"
    fi

    # Remove existing symlink or file
    if [ -L "$dst" ] || [ -f "$dst" ]; then
        rm "$dst"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    # Create symlink
    ln -s "$src" "$dst"
    echo "  ✅ Linked: $dst → $src"
}

# home/.config/ files
link_file "$HOMEDIR/.config/git/config"       "$HOME/.config/git/config"
link_file "$HOMEDIR/.config/git/ignore"       "$HOME/.config/git/ignore"
link_file "$HOMEDIR/.config/starship.toml"    "$HOME/.config/starship.toml"
link_file "$HOMEDIR/.config/ghostty/config"   "$HOME/.config/ghostty/config"
link_file "$HOMEDIR/.config/tmux/tmux.conf"   "$HOME/.config/tmux/tmux.conf"
link_file "$HOMEDIR/.config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# home/ top-level dotfiles
link_file "$HOMEDIR/.gitconfig"               "$HOME/.gitconfig"

# AI agent skills
link_file "$HOMEDIR/.agents/skills"           "$HOME/.agents/skills"

# Pi extensions
link_file "$HOMEDIR/.pi/agent/extensions/whimsical.ts" "$HOME/.pi/agent/extensions/whimsical.ts"

echo ""
echo "🎉 Done! Your dotfiles are symlinked."
echo "   Edit any config in ~/ and the change is tracked in ~/dotfiles/home/"
