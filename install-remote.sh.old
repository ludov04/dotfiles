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
# Install modern CLI tools
# -----------------------------------------------------------------------------
echo "==> Installing CLI tools"

# Detect package manager
if command -v apt-get &>/dev/null; then
    PKG_MGR="apt"
    sudo apt-get update -qq
elif command -v apk &>/dev/null; then
    PKG_MGR="apk"
elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
elif command -v yum &>/dev/null; then
    PKG_MGR="yum"
else
    PKG_MGR=""
fi

# Install starship
if ! command -v starship &>/dev/null; then
    echo "    Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

# Install eza (modern ls)
if ! command -v eza &>/dev/null; then
    echo "    Installing eza..."
    if [[ "$PKG_MGR" == "apt" ]]; then
        sudo apt-get install -y gpg
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo apt-get update -qq && sudo apt-get install -y eza
    elif [[ "$PKG_MGR" == "apk" ]]; then
        sudo apk add eza
    fi
fi

# Install bat (modern cat)
if ! command -v bat &>/dev/null && ! command -v batcat &>/dev/null; then
    echo "    Installing bat..."
    if [[ "$PKG_MGR" == "apt" ]]; then
        sudo apt-get install -y bat
        # Debian/Ubuntu install it as batcat
        [[ -f /usr/bin/batcat ]] && sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
    elif [[ "$PKG_MGR" == "apk" ]]; then
        sudo apk add bat
    fi
fi

# Install ripgrep
if ! command -v rg &>/dev/null; then
    echo "    Installing ripgrep..."
    if [[ "$PKG_MGR" == "apt" ]]; then
        sudo apt-get install -y ripgrep
    elif [[ "$PKG_MGR" == "apk" ]]; then
        sudo apk add ripgrep
    fi
fi

# Install zoxide (smarter cd)
if ! command -v zoxide &>/dev/null; then
    echo "    Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# Install fzf (fuzzy finder)
if ! command -v fzf &>/dev/null; then
    echo "    Installing fzf..."
    if [[ "$PKG_MGR" == "apt" ]]; then
        sudo apt-get install -y fzf
    elif [[ "$PKG_MGR" == "apk" ]]; then
        sudo apk add fzf
    fi
fi

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
backup_if_exists "$HOME/.config/starship.toml"

# -----------------------------------------------------------------------------
# Create symlinks
# -----------------------------------------------------------------------------
echo "==> Creating symlinks"

# Remove old symlinks first
rm -f "$HOME/.zshenv"
rm -rf "$HOME/.config/zsh"
rm -rf "$HOME/.config/git"
rm -f "$HOME/.config/starship.toml"

# Create new symlinks
ln -sf "$DOTFILES/home/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/config/zsh" "$HOME/.config/zsh"
ln -sf "$DOTFILES/config/git" "$HOME/.config/git"
ln -sf "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"

echo "    ~/.zshenv -> $DOTFILES/home/.zshenv"
echo "    ~/.config/zsh -> $DOTFILES/config/zsh"
echo "    ~/.config/git -> $DOTFILES/config/git"
echo "    ~/.config/starship.toml -> $DOTFILES/config/starship.toml"

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "==> Done! Restart your shell or run: exec zsh"
echo ""
echo "Note: This is a minimal install for remote environments."
echo "For full setup (Homebrew, mise, etc.), run install.sh instead."
