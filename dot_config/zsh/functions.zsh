# =============================================================================
# Functions
# =============================================================================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick find file by name
ff() {
    find . -name "*$1*" 2>/dev/null
}

# Extract various archive formats
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.bz2) tar xjf "$1" ;;
            *.tar.gz)  tar xzf "$1" ;;
            *.tar.xz)  tar xJf "$1" ;;
            *.bz2)     bunzip2 "$1" ;;
            *.gz)      gunzip "$1" ;;
            *.tar)     tar xf "$1" ;;
            *.tbz2)    tar xjf "$1" ;;
            *.tgz)     tar xzf "$1" ;;
            *.zip)     unzip "$1" ;;
            *.Z)       uncompress "$1" ;;
            *.7z)      7z x "$1" ;;
            *)         echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# -----------------------------------------------------------------------------
# Node.js / pnpm functions
# -----------------------------------------------------------------------------

# Find and list all node_modules directories with sizes
node-modules() {
    echo "Finding node_modules directories..."
    fd -t d -H "node_modules" --prune -x du -sh {} | sort -hr
}

# Clean node_modules in current project
node-clean() {
    if [[ -d "node_modules" ]]; then
        echo "Removing node_modules..."
        rm -rf node_modules
        echo "Done! Run 'pnpm install' to reinstall."
    else
        echo "No node_modules directory found."
    fi
}

# Clean ALL node_modules recursively (use with caution!)
node-clean-all() {
    echo "This will delete ALL node_modules directories under $(pwd)"
    echo -n "Are you sure? (y/N) "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        fd -t d -H "node_modules" --prune -x rm -rf {}
        echo "Done!"
    else
        echo "Cancelled."
    fi
}

# Check for outdated packages (interactive with fzf)
pnpm-outdated() {
    pnpm outdated 2>/dev/null | tail -n +2 | fzf --header="Outdated packages (Enter to update)" \
        --preview="pnpm why {1}" \
        --bind="enter:execute(pnpm update {1})+reload(pnpm outdated 2>/dev/null | tail -n +2)"
}

# Quick script runner with fzf
pnpm-run() {
    local script
    script=$(jq -r '.scripts | keys[]' package.json 2>/dev/null | fzf --header="Select script to run")
    [[ -n "$script" ]] && pnpm run "$script"
}

# Show dependency tree for a package
pnpm-tree() {
    pnpm why "$1" --depth=10
}

# -----------------------------------------------------------------------------
# AWS CLI profile switching
# Native equivalents of oh-my-zsh's aws plugin (we don't run oh-my-zsh).
# The active profile shows in the prompt via starship's [aws] module.
# Profiles come from ~/.aws/config (SSO) - no static keys needed.
# -----------------------------------------------------------------------------

# List configured profiles
aws-profiles() {
    aws configure list-profiles 2>/dev/null
}

# agp - "aws get profile": print the active profile
agp() {
    echo "${AWS_PROFILE:-default}"
}

# asp - "aws set profile": set AWS_PROFILE for the current shell.
#   asp <profile>   set the given profile
#   asp             pick interactively with fzf (if installed)
#   asp -u          clear the active profile
asp() {
    if [[ "$1" == "-u" || "$1" == "--unset" ]]; then
        unset AWS_PROFILE AWS_DEFAULT_PROFILE AWS_EB_PROFILE
        return
    fi
    local profile="$1"
    if [[ -z "$profile" ]]; then
        command -v fzf &>/dev/null || { echo "usage: asp <profile> | asp -u"; return 1; }
        profile=$(aws-profiles | fzf --height=40% --reverse --header="Select AWS profile") || return
    fi
    [[ -z "$profile" ]] && return
    export AWS_PROFILE="$profile"
    export AWS_DEFAULT_PROFILE="$profile"
}

# Tab-completion for `asp` from configured profiles
if (( $+functions[compdef] )); then
    _asp() {
        local -a profiles
        profiles=(${(f)"$(aws configure list-profiles 2>/dev/null)"})
        compadd -a profiles
    }
    compdef _asp asp
fi
