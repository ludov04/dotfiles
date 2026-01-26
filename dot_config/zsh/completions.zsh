# =============================================================================
# Completions & History Configuration
# =============================================================================

# -----------------------------------------------------------------------------
# History settings
# -----------------------------------------------------------------------------
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000

setopt EXTENDED_HISTORY          # Write timestamp to history
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicates first
setopt HIST_IGNORE_DUPS          # Don't record duplicates
setopt HIST_IGNORE_SPACE         # Don't record commands starting with space
setopt HIST_VERIFY               # Show command before executing from history
setopt SHARE_HISTORY             # Share history between sessions
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks

# -----------------------------------------------------------------------------
# Completion settings
# -----------------------------------------------------------------------------
# Load completion system
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Menu selection (tab to cycle through options)
zstyle ':completion:*' menu select

# Group completions by type
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:corrections' format '%F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:messages' format '%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- no matches found --%f'

# Colors in completion menu (like ls)
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Complete . and .. directories
zstyle ':completion:*' special-dirs true

# Cache completions for faster loading
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Complete commands after sudo/doas
zstyle ':completion::complete:*' gain-privileges 1

# Better process completion
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# SSH/SCP completion from known_hosts
zstyle ':completion:*:(ssh|scp|rsync):*' hosts off
zstyle ':completion:*:(ssh|scp|rsync):*' users off

# -----------------------------------------------------------------------------
# Key bindings for completion
# -----------------------------------------------------------------------------
# Use vim keys in menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Shift+Tab to go backwards in menu
bindkey -M menuselect '^[[Z' reverse-menu-complete

# -----------------------------------------------------------------------------
# History search - Up/Down arrows search through history
# -----------------------------------------------------------------------------
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[A' up-line-or-beginning-search    # Up arrow
bindkey '^[[B' down-line-or-beginning-search  # Down arrow
bindkey '^P' up-line-or-beginning-search      # Ctrl+P
bindkey '^N' down-line-or-beginning-search    # Ctrl+N

# -----------------------------------------------------------------------------
# fzf integration (fuzzy finder)
# -----------------------------------------------------------------------------
if [[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

if [[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]]; then
    source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi

# fzf settings
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border
  --info=inline
  --margin=1
  --padding=1
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
  --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
"

# Ctrl+R: Fuzzy search history (fzf overrides this)
# Ctrl+T: Fuzzy search files
# Alt+C: Fuzzy cd to directory

# Use fd for fzf if available (faster than find)
if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# -----------------------------------------------------------------------------
# pnpm completions
# -----------------------------------------------------------------------------
if command -v pnpm &>/dev/null; then
    eval "$(pnpm completion zsh)"
fi

# -----------------------------------------------------------------------------
# zsh-autosuggestions settings
# -----------------------------------------------------------------------------
# Suggestion strategy: history first, then completion
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

# Accept suggestion with Right arrow or End key
bindkey '^[[C' forward-char                   # Right arrow: accept one char
bindkey '^[[F' end-of-line                    # End: accept full suggestion

# Accept full suggestion with Ctrl+Space
bindkey '^ ' autosuggest-accept

# Partial accept with Ctrl+Right (accept word)
bindkey '^[[1;5C' forward-word

# -----------------------------------------------------------------------------
# Additional useful bindings
# -----------------------------------------------------------------------------
# Ctrl+U: Clear line before cursor
bindkey '^U' backward-kill-line

# Ctrl+K: Clear line after cursor
bindkey '^K' kill-line

# Ctrl+W: Delete word backwards
bindkey '^W' backward-kill-word

# Alt+Backspace: Delete word backwards (macOS friendly)
bindkey '^[^?' backward-kill-word

# Ctrl+A: Beginning of line
bindkey '^A' beginning-of-line

# Ctrl+E: End of line
bindkey '^E' end-of-line
