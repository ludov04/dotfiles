# =============================================================================
# Aliases
# =============================================================================

# Package managers - pnpm
alias pn='pnpm'
alias px='pnpx'
alias pi='pnpm install'
alias pa='pnpm add'
alias pad='pnpm add -D'
alias prm='pnpm remove'
alias pu='pnpm update'
alias pr='pnpm run'
alias pd='pnpm dev'
alias pb='pnpm build'
alias pt='pnpm test'
alias pw='pnpm watch'
alias pex='pnpm exec'
alias po='pnpm outdated'
alias pls='pnpm list'
alias pwhy='pnpm why'

# Note: ls/ll/la aliases are in tools.zsh (uses eza if available)

# Use difftastic for diffs
alias diff='difft'

# Ripgrep search (exclude node_modules)
alias search='rg -p --glob "!node_modules/*"'

# Git shortcuts
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline -20'
alias gco='git checkout'
alias gb='git branch'
alias ga='git add'
alias gaa='git add -A'

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety
alias rm='rm -i'
alias mv='mv -i'
alias cp='cp -i'

# Misc
alias c='clear'
alias h='history'
alias j='jobs'

# Claude
alias claude-mem='bun "$HOME/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
