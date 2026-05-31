#!/bin/bash
# Dotfiles install script
# Run this on a new machine to create all symlinks

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "🔗 Setting up dotfiles from: $DOTFILES_DIR"

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

# Git config
link_file "$DOTFILES_DIR/.config/git/config" "$HOME/.config/git/config"

# Starship
link_file "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"

# Ghostty
link_file "$DOTFILES_DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"

# Tmux
link_file "$DOTFILES_DIR/.config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

# Lazygit
link_file "$DOTFILES_DIR/.config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

echo ""
echo "🎉 Done! Your dotfiles are symlinked."
echo "   Edit any config in ~/.config/ and the change is tracked in ~/dotfiles/"
