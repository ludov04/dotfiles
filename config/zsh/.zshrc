# =============================================================================
# ZSH Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# PATH additions
# -----------------------------------------------------------------------------
# Dotfiles bin directory
export PATH="$HOME/dotfiles/bin:$PATH"

# -----------------------------------------------------------------------------
# Homebrew (must be first for PATH)
# -----------------------------------------------------------------------------
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# -----------------------------------------------------------------------------
# mise (version manager for node, go, python, etc.)
# -----------------------------------------------------------------------------
if command -v mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# -----------------------------------------------------------------------------
# Prompt (Starship)
# -----------------------------------------------------------------------------
if command -v starship &>/dev/null; then
    eval "$(starship init zsh)"
fi

# -----------------------------------------------------------------------------
# Source modular configs (order matters!)
# -----------------------------------------------------------------------------
# 1. Completions first (sets up history, completion system, fzf, key bindings)
[[ -f "$ZDOTDIR/completions.zsh" ]] && source "$ZDOTDIR/completions.zsh"

# 2. Modern CLI tools (zoxide, eza, bat, atuin, direnv)
[[ -f "$ZDOTDIR/tools.zsh" ]] && source "$ZDOTDIR/tools.zsh"

# 3. Aliases
[[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"

# 4. Functions
[[ -f "$ZDOTDIR/functions.zsh" ]] && source "$ZDOTDIR/functions.zsh"

# -----------------------------------------------------------------------------
# Zsh plugins (via Homebrew) - AFTER completions.zsh sets strategies
# -----------------------------------------------------------------------------
# Autosuggestions (shows inline suggestions from history)
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Fast syntax highlighting (better than zsh-syntax-highlighting - must be last!)
if [[ -f /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]]; then
    source /opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
fi

# -----------------------------------------------------------------------------
# 1Password CLI plugin (if exists)
# -----------------------------------------------------------------------------
if [[ -f "$HOME/.config/op/plugins.sh" ]]; then
    source "$HOME/.config/op/plugins.sh"
fi
export PATH="$HOME/.local/bin:$PATH"
