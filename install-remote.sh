#!/bin/bash
# =============================================================================
# Dotfiles Install Script (Remote/Minimal - for CDEs)
# =============================================================================
set -e

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

echo "==> Installing dotfiles (minimal) from $DOTFILES"

# -----------------------------------------------------------------------------
# Create XDG directories
# -----------------------------------------------------------------------------
echo "==> Creating XDG directories"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/share"
mkdir -p "$HOME/.local/state/zsh"
mkdir -p "$HOME/.cache/zsh"

# -----------------------------------------------------------------------------
# Backup existing configs
# -----------------------------------------------------------------------------
backup_if_exists() {
    if [[ -e "$1" && ! -L "$1" ]]; then
        echo "    Backing up $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

echo "==> Backing up existing configs (if any)"
backup_if_exists "$HOME/.zshenv"
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.config/zsh"
backup_if_exists "$HOME/.config/git"

# -----------------------------------------------------------------------------
# Create symlinks
# -----------------------------------------------------------------------------
echo "==> Creating symlinks"

# Remove old symlinks first
rm -f "$HOME/.zshenv"
rm -rf "$HOME/.config/zsh"
rm -rf "$HOME/.config/git"

# Create new symlinks
ln -sf "$DOTFILES/home/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/config/zsh" "$HOME/.config/zsh"
ln -sf "$DOTFILES/config/git" "$HOME/.config/git"

echo "    ~/.zshenv -> $DOTFILES/home/.zshenv"
echo "    ~/.config/zsh -> $DOTFILES/config/zsh"
echo "    ~/.config/git -> $DOTFILES/config/git"

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "==> Done! Restart your shell or run: exec zsh"
echo ""
echo "Note: This is a minimal install for remote environments."
echo "For full setup (Homebrew, mise, etc.), run install.sh instead."
