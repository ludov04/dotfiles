# Architecture

**Analysis Date:** 2026-01-17

## Pattern Overview

**Overall:** Symlink-based dotfiles manager with XDG-compliant configuration

**Key Characteristics:**
- Configuration files stored in repo, symlinked to standard locations
- XDG Base Directory Specification for organized config paths
- Modular shell configuration with separate concern files
- Two installation modes: full (macOS) and minimal (remote/CDE)

## Layers

**Bootstrap Layer:**
- Purpose: Initialize XDG environment variables and set ZDOTDIR
- Location: `home/.zshenv`
- Contains: XDG env exports, ZDOTDIR pointer
- Depends on: Nothing (first file sourced by zsh)
- Used by: All subsequent zsh configuration

**Installation Layer:**
- Purpose: Create symlinks, install dependencies, set up environment
- Location: `install.sh`, `install-remote.sh`
- Contains: Backup logic, symlink creation, tool installation
- Depends on: Bootstrap layer config paths
- Used by: User during initial setup

**Shell Configuration Layer:**
- Purpose: Configure zsh behavior, aliases, functions
- Location: `config/zsh/`
- Contains: `.zshrc` (main), `aliases.zsh`, `functions.zsh`, `completions.zsh`, `tools.zsh`
- Depends on: Bootstrap layer, installed CLI tools
- Used by: Every interactive shell session

**Tool Configuration Layer:**
- Purpose: Configure external tools (git, tmux, starship, ghostty)
- Location: `config/{git,tmux,starship.toml,ghostty}/`
- Contains: Tool-specific configuration files
- Depends on: Tools being installed
- Used by: Respective tools when invoked

**Utility Scripts Layer:**
- Purpose: Provide maintenance and helper scripts
- Location: `bin/`
- Contains: Executable shell scripts
- Depends on: Installed CLI tools (brew, docker, etc.)
- Used by: User via PATH

## Data Flow

**Shell Initialization:**

1. Zsh sources `~/.zshenv` (symlink to `home/.zshenv`)
2. XDG variables and ZDOTDIR set
3. Zsh sources `$ZDOTDIR/.zshrc` (symlink to `config/zsh/.zshrc`)
4. `.zshrc` initializes Homebrew, mise, starship
5. Modular configs sourced in order: completions, tools, aliases, functions
6. Zsh plugins loaded (autosuggestions, syntax highlighting)

**Installation Flow:**

1. User runs `install.sh` or `install-remote.sh`
2. XDG directories created (`~/.config`, `~/.local/{share,state,cache}`)
3. Existing configs backed up if non-symlinks exist
4. Symlinks created from `~/.config/*` to `~/dotfiles/config/*`
5. Platform-specific setup (Homebrew on macOS, package managers on Linux)
6. Tool managers initialized (mise, tmux plugins)

**State Management:**
- Shell history: `$XDG_STATE_HOME/zsh/history`
- Completion cache: `$XDG_CACHE_HOME/zsh/zcompdump`
- Tmux sessions: `~/.local/share/tmux/resurrect`
- Zoxide database: Managed by zoxide

## Key Abstractions

**Modular Zsh Configuration:**
- Purpose: Separate shell concerns into focused files
- Examples: `config/zsh/aliases.zsh`, `config/zsh/tools.zsh`, `config/zsh/functions.zsh`
- Pattern: Each file handles one category of configuration

**XDG Directory Mapping:**
- Purpose: Keep home directory clean, follow standards
- Examples: `~/.config` for configs, `~/.local/share` for data, `~/.cache` for cache
- Pattern: All tools configured to use XDG paths where possible

**Conditional Tool Loading:**
- Purpose: Gracefully degrade when tools not installed
- Examples: `if command -v zoxide &>/dev/null; then eval "$(zoxide init zsh)"; fi`
- Pattern: Check tool existence before initialization

## Entry Points

**Shell Entry:**
- Location: `home/.zshenv`
- Triggers: Every zsh invocation (login, interactive, script)
- Responsibilities: Set XDG vars, point to ZDOTDIR

**Interactive Shell Entry:**
- Location: `config/zsh/.zshrc`
- Triggers: Interactive shell start
- Responsibilities: Full environment setup, tool init, load modules

**Installation Entry:**
- Location: `install.sh` (macOS), `install-remote.sh` (Linux/CDE)
- Triggers: Manual execution by user
- Responsibilities: Full system setup, dependency installation

**Utility Entry:**
- Location: `bin/*` scripts
- Triggers: User command execution
- Responsibilities: Specific maintenance tasks

## Error Handling

**Strategy:** Defensive with silent fallbacks

**Patterns:**
- `command -v tool &>/dev/null` checks before using optional tools
- `|| true` suffix on commands that may fail harmlessly
- Backup existing files before overwriting with symlinks
- `set -e` in install scripts to stop on first error

## Cross-Cutting Concerns

**Logging:** Echo statements in install scripts; no logging in shell configs

**Theming:** Catppuccin Mocha theme across tools (starship, fzf, tmux, ghostty)

**Security:**
- SSH agent forwarding via 1Password
- Git commit signing with SSH keys via 1Password
- Touch ID for sudo (macOS)

---

*Architecture analysis: 2026-01-17*
