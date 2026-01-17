# Coding Conventions

**Analysis Date:** 2026-01-17

## Overview

This is a dotfiles repository containing shell scripts (Bash), Zsh configuration, and various tool configurations. The conventions focus on shell scripting best practices and configuration organization.

## Naming Patterns

**Files:**
- Executable scripts: `lowercase-with-dashes` (e.g., `update-all`, `macos-defaults`)
- Zsh modules: `lowercase.zsh` (e.g., `aliases.zsh`, `functions.zsh`)
- Config files: tool-specific conventions (e.g., `tmux.conf`, `config.toml`)
- Hidden entry points: `.zshenv`, `.zshrc` (Zsh standard)

**Functions:**
- Zsh functions: `lowercase-with-dashes` or `lowercase_underscores`
  - Examples: `mkcd`, `node-modules`, `node-clean-all`, `pnpm-run`
- Utility functions: descriptive verbs (e.g., `extract`, `backup_if_exists`)

**Variables:**
- Environment variables: `UPPERCASE_WITH_UNDERSCORES`
  - Examples: `DOTFILES`, `XDG_CONFIG_HOME`, `ZDOTDIR`
- Local script variables: `UPPERCASE` for constants, `lowercase` for locals
  - Examples: `PAM_FILE`, `PKG_MGR`, `script`

**Aliases:**
- Short mnemonics: 1-4 characters for frequent commands
  - Examples: `g` (git), `gs` (git status), `pn` (pnpm)
- Descriptive for less frequent: `search`, `diff`

## Code Style

**Shell Scripts:**

All shell scripts follow these patterns:

```bash
#!/bin/bash
# =============================================================================
# Script Title - Brief Description
# Run: command [args]
# =============================================================================
set -e

# Code here...
```

**Section Headers:**

Use consistent comment blocks for organization:

```bash
# -----------------------------------------------------------------------------
# Section Name
# -----------------------------------------------------------------------------
```

**Zsh Configuration:**

```zsh
# =============================================================================
# Module Title
# =============================================================================

# -----------------------------------------------------------------------------
# Subsection Name
# -----------------------------------------------------------------------------
# Optional: description of what this section does
code_here
```

## File Organization

**Modular Zsh Config:**
- `config/zsh/.zshrc` - Main entry point, sources other modules
- `config/zsh/completions.zsh` - Completion and history settings
- `config/zsh/tools.zsh` - Modern CLI tool configuration
- `config/zsh/aliases.zsh` - Command aliases
- `config/zsh/functions.zsh` - Shell functions

**Load Order Matters:**
1. Completions first (sets up history, completion system, fzf, key bindings)
2. Modern CLI tools (zoxide, eza, bat, atuin, direnv)
3. Aliases
4. Functions
5. Plugins (autosuggestions, syntax highlighting - must be last)

## Error Handling

**Scripts:**
- Always use `set -e` at the top to exit on errors
- Use `|| true` for commands that may fail but should not stop execution:
  ```bash
  npm cache clean --force 2>/dev/null || true
  ```
- Redirect errors to `/dev/null` when checking command existence:
  ```bash
  if command -v brew &>/dev/null; then
  ```

**Conditional Execution:**
- Check command existence before using:
  ```bash
  if command -v zoxide &>/dev/null; then
      eval "$(zoxide init zsh)"
  fi
  ```
- Check file existence before sourcing:
  ```bash
  [[ -f "$ZDOTDIR/aliases.zsh" ]] && source "$ZDOTDIR/aliases.zsh"
  ```

## Output Patterns

**Progress Indicators:**
- Use `==>` prefix for major steps:
  ```bash
  echo "==> Installing Homebrew packages"
  ```
- Use `    ` (4 spaces) for sub-items:
  ```bash
  echo "    ~/.config/zsh -> $DOTFILES/config/zsh"
  ```

**User Confirmation:**
```bash
echo -n "Are you sure? (y/N) "
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    # proceed
fi
```

## Comments

**When to Comment:**
- Section headers (always)
- Complex logic or non-obvious behavior
- Usage instructions for scripts and functions
- Configuration options that need explanation

**Format:**
- Inline comments after code: `command  # Explanation`
- Block comments above code for longer explanations
- Usage in function header:
  ```bash
  # Usage: z <partial-path>  (e.g., z dotfiles, z proj)
  ```

**Cheatsheets in Config:**
Include usage instructions at top of config files (see `config/tmux/tmux.conf`):
```bash
# QUICK START:
#   Start tmux:        tmux
#   New session:       tmux new -s myproject
#
# CHEATSHEET (all commands start with Ctrl+a, then...):
#   ?         Show all keybindings
```

## Function Design

**Pattern - Guard Clauses:**
```bash
extract() {
    if [[ -f "$1" ]]; then
        case "$1" in
            *.tar.gz)  tar xzf "$1" ;;
            *)         echo "'$1' cannot be extracted" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
```

**Pattern - Confirmation for Destructive Operations:**
```bash
node-clean-all() {
    echo "This will delete ALL node_modules directories under $(pwd)"
    echo -n "Are you sure? (y/N) "
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        fd -t d -H "node_modules" --prune -x rm -rf {}
    else
        echo "Cancelled."
    fi
}
```

**Pattern - Interactive Selection with fzf:**
```bash
pnpm-run() {
    local script
    script=$(jq -r '.scripts | keys[]' package.json 2>/dev/null | fzf --header="Select script")
    [[ -n "$script" ]] && pnpm run "$script"
}
```

## Import/Sourcing Organization

**Order in .zshrc:**
1. PATH additions
2. Tool initialization (Homebrew, mise, starship)
3. Modular config sources (completions, tools, aliases, functions)
4. Plugins (via Homebrew)
5. Additional integrations (1Password CLI)

**Pattern for Optional Sources:**
```bash
[[ -f "$path" ]] && source "$path"
```

## Path Handling

**Use Variables:**
```bash
DOTFILES="${DOTFILES:-$HOME/dotfiles}"
```

**XDG Compliance:**
```bash
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
```

**Always Quote Paths:**
```bash
ln -sf "$DOTFILES/config/zsh" "$HOME/.config/zsh"
```

## Symlink Management

**Pattern - Backup Before Replace:**
```bash
backup_if_exists() {
    if [[ -e "$1" && ! -L "$1" ]]; then
        echo "    Backing up $1 to $1.backup"
        rm -rf "$1.backup"
        mv -f "$1" "$1.backup"
    fi
}
```

**Pattern - Clean Before Create:**
```bash
rm -f "$HOME/.zshenv"
ln -sf "$DOTFILES/home/.zshenv" "$HOME/.zshenv"
```

## Alias Conventions

**Grouped by Tool/Purpose:**
```bash
# Package managers - pnpm
alias pn='pnpm'
alias pi='pnpm install'

# Git shortcuts
alias g='git'
alias gs='git status'
```

**Short Aliases for Frequent Commands:**
- Single letter: `g` (git), `c` (clear), `h` (history)
- Two letters: `gs` (git status), `gd` (git diff)
- Three+ for specifics: `gaa` (git add -A)

**Modern Tool Aliases:**
Prefer modern replacements when available:
```bash
if command -v eza &>/dev/null; then
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first --git'
fi
```

## Environment Variables

**Required vs Optional:**
- Document required variables in `.gitignore` comments
- Use defaults for optional:
  ```bash
  DOTFILES="${DOTFILES:-$HOME/dotfiles}"
  ```

**Never Commit Secrets:**
Files listed in `.gitignore`:
- `*.pem`, `*.key`
- `.env`, `.env.*`
- Credentials documented but not stored

---

*Convention analysis: 2026-01-17*
