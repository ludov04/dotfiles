# =============================================================================
# Modern CLI Tools Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# zoxide - smarter cd
# Usage: z <partial-path>  (e.g., z dotfiles, z proj)
# -----------------------------------------------------------------------------
if command -v zoxide &>/dev/null; then
    eval "$(zoxide init zsh)"
    # Alias cd to zoxide (optional - uncomment if you want)
    # alias cd='z'
fi

# -----------------------------------------------------------------------------
# atuin - better shell history
# Replaces Ctrl+R with better searchable history
# -----------------------------------------------------------------------------
if command -v atuin &>/dev/null; then
    eval "$(atuin init zsh --disable-up-arrow)"
    # Note: --disable-up-arrow keeps the default up arrow behavior
    # Remove it if you want atuin to handle up arrow too
fi

# -----------------------------------------------------------------------------
# direnv - auto-load .envrc files
# Create .envrc in project dirs to auto-set env vars
# -----------------------------------------------------------------------------
if command -v direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# -----------------------------------------------------------------------------
# eza - modern ls replacement
# -----------------------------------------------------------------------------
if command -v eza &>/dev/null; then
    # Basic aliases
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first --git'
    alias la='eza -la --icons --group-directories-first --git'
    alias lt='eza --tree --icons --level=2'
    alias lta='eza --tree --icons --level=2 -a'

    # Extended aliases
    alias l='eza -l --icons'
    alias lg='eza -l --icons --git'          # Show git status
    alias lm='eza -l --icons --sort=modified' # Sort by modified
    alias lk='eza -l --icons --sort=size'     # Sort by size
fi

# -----------------------------------------------------------------------------
# bat - modern cat with syntax highlighting
# -----------------------------------------------------------------------------
if command -v bat &>/dev/null; then
    alias cat='bat --paging=never'
    alias catp='bat'                          # bat with pager
    alias bathelp='bat --plain --language=help'

    # Use bat for man pages (colored!)
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT="-c"

    # Use bat for --help output
    help() {
        "$@" --help 2>&1 | bat --plain --language=help
    }
fi

# -----------------------------------------------------------------------------
# tldr - simplified man pages
# Usage: tldr <command>
# -----------------------------------------------------------------------------
# tlrc is the Rust implementation (faster)
# Just works after install, no config needed

# -----------------------------------------------------------------------------
# fzf enhancements with new tools
# -----------------------------------------------------------------------------
# Use bat for fzf preview
if command -v bat &>/dev/null && command -v fzf &>/dev/null; then
    export FZF_CTRL_T_OPTS="
        --preview 'bat -n --color=always {}'
        --bind 'ctrl-/:change-preview-window(down|hidden|)'"
fi

# Use eza for fzf directory preview
if command -v eza &>/dev/null && command -v fzf &>/dev/null; then
    export FZF_ALT_C_OPTS="--preview 'eza --tree --icons --level=2 {}'"
fi
