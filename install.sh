#!/bin/bash
# =============================================================================
# Dotfiles Install Script (Full - macOS)
# =============================================================================
set -e

DOTFILES="${DOTFILES:-$HOME/dotfiles}"

echo "==> Installing dotfiles from $DOTFILES"

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
        rm -rf "$1.backup"
        mv -f "$1" "$1.backup"
    fi
}

echo "==> Backing up existing configs (if any)"
backup_if_exists "$HOME/.zshenv"
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.config/zsh"
backup_if_exists "$HOME/.config/git"
backup_if_exists "$HOME/.config/mise"
backup_if_exists "$HOME/.config/ghostty"
backup_if_exists "$HOME/.config/starship.toml"
backup_if_exists "$HOME/.tmux.conf"
backup_if_exists "$HOME/.config/tmux"

# -----------------------------------------------------------------------------
# Create symlinks
# -----------------------------------------------------------------------------
echo "==> Creating symlinks"

# Remove old symlinks first
rm -f "$HOME/.zshenv"
rm -rf "$HOME/.config/zsh"
rm -rf "$HOME/.config/git"
rm -rf "$HOME/.config/mise"
rm -f "$HOME/.config/starship.toml"
rm -f "$HOME/.tmux.conf"
rm -rf "$HOME/.config/ghostty"
rm -rf "$HOME/.config/tmux"

# Create new symlinks
ln -sf "$DOTFILES/home/.zshenv" "$HOME/.zshenv"
ln -sf "$DOTFILES/config/zsh" "$HOME/.config/zsh"
ln -sf "$DOTFILES/config/git" "$HOME/.config/git"
ln -sf "$DOTFILES/config/mise" "$HOME/.config/mise"
ln -sf "$DOTFILES/config/ghostty" "$HOME/.config/ghostty"
ln -sf "$DOTFILES/config/starship.toml" "$HOME/.config/starship.toml"

# tmux config (both locations for compatibility)
mkdir -p "$HOME/.config/tmux"
ln -sf "$DOTFILES/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
ln -sf "$DOTFILES/config/tmux/tmux.conf" "$HOME/.tmux.conf"

echo "    ~/.zshenv -> $DOTFILES/home/.zshenv"
echo "    ~/.config/zsh -> $DOTFILES/config/zsh"
echo "    ~/.config/git -> $DOTFILES/config/git"
echo "    ~/.config/mise -> $DOTFILES/config/mise"
echo "    ~/.config/starship.toml -> $DOTFILES/config/starship.toml"
echo "    ~/.config/tmux/tmux.conf -> $DOTFILES/config/tmux/tmux.conf"

# Claude Code config
mkdir -p "$HOME/.claude/commands"
ln -sf "$DOTFILES/config/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
ln -sf "$DOTFILES/config/claude/settings.json" "$HOME/.claude/settings.json"
for cmd in "$DOTFILES/config/claude/commands"/*.md; do
    ln -sf "$cmd" "$HOME/.claude/commands/$(basename "$cmd")"
done
echo "    ~/.claude/CLAUDE.md -> $DOTFILES/config/claude/CLAUDE.md"
echo "    ~/.claude/commands/ -> $DOTFILES/config/claude/commands/"

# -----------------------------------------------------------------------------
# macOS specific setup
# -----------------------------------------------------------------------------
if [[ "$(uname)" == "Darwin" ]]; then
    echo "==> macOS detected"

    # Install Homebrew if not present
    if ! command -v brew &>/dev/null; then
        echo "==> Installing Homebrew"
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Install packages from Brewfile
    if [[ -f "$DOTFILES/Brewfile" ]]; then
        echo "==> Installing Homebrew packages"
        brew bundle --file="$DOTFILES/Brewfile" --no-lock
    fi

    # Setup mise
    if command -v mise &>/dev/null; then
        echo "==> Setting up mise"
        eval "$(mise activate bash)"
        mise install --yes
    fi
fi

# -----------------------------------------------------------------------------
# tmux plugin manager
# -----------------------------------------------------------------------------
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    echo "==> Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Install tmux plugins
if [[ -f "$HOME/.tmux/plugins/tpm/bin/install_plugins" ]]; then
    echo "==> Installing tmux plugins"
    ~/.tmux/plugins/tpm/bin/install_plugins
fi

# -----------------------------------------------------------------------------
# Done
# -----------------------------------------------------------------------------
echo ""
echo "==> Done! Restart your shell or run: exec zsh"
echo ""
echo "Next steps:"
echo "  1. Open a new terminal"
echo "  2. Run 'mise install' to install language versions"
echo "  3. Customize configs in $DOTFILES"
