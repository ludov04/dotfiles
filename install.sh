#!/bin/bash
# =============================================================================
# Dotfiles Bootstrap Script
# =============================================================================
# This script is for initial setup and devpod/container compatibility.
# Devpod clones the dotfiles repo and runs install.sh automatically.
#
# Usage:
#   ./install.sh              # Install from local repo
#   curl ... | sh             # One-liner bootstrap (see README)
# =============================================================================
set -e

DOTFILES_REPO="https://github.com/ludov/dotfiles.git"

echo "==> Bootstrapping dotfiles with chezmoi..."

# Install chezmoi if not present
if ! command -v chezmoi &>/dev/null; then
    echo "==> Installing chezmoi..."
    sh -c "$(curl -fsLS get.chezmoi.io)" -- -b "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$PATH"
fi

# Determine source directory
if [[ -f "$(pwd)/.chezmoi.toml.tmpl" ]]; then
    # Running from within the cloned repo (devpod scenario)
    CHEZMOI_SOURCE="$(pwd)"
    echo "==> Using local source: $CHEZMOI_SOURCE"
    chezmoi init --apply --source="$CHEZMOI_SOURCE"
else
    # Running standalone, clone from remote
    echo "==> Cloning from: $DOTFILES_REPO"
    chezmoi init --apply "$DOTFILES_REPO"
fi

echo ""
echo "==> Done! Restart your shell or run: exec zsh"
echo ""
echo "Chezmoi commands:"
echo "  chezmoi diff     # See pending changes"
echo "  chezmoi apply    # Apply changes"
echo "  chezmoi edit     # Edit source files"
echo "  chezmoi cd       # Go to source directory"
