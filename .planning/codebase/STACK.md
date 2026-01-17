# Technology Stack

**Analysis Date:** 2026-01-17

## Languages

**Primary:**
- Bash (Shell scripts) - All install scripts, utility scripts in `bin/`
- Zsh (Shell config) - Shell configuration in `config/zsh/`

**Configuration Languages:**
- TOML - `config/mise/config.toml`, `config/starship.toml`
- JSON - `config/claude/settings.json`
- INI-style - `config/git/config`, `config/ssh/config`

## Runtime

**Environment:**
- macOS (Darwin) - Primary target platform
- Linux - Secondary target via `install-remote.sh` for CDEs

**Shell:**
- Zsh - Primary shell
- Bash - Script execution

**Version Manager:**
- mise - Manages runtime versions for Node.js, Go, Bun, Python, Ruby, Rust
- Config: `config/mise/config.toml`

## Frameworks

**Shell Prompt:**
- Starship - Cross-shell prompt
- Config: `config/starship.toml`
- Theme: Catppuccin Mocha palette

**Terminal Multiplexer:**
- tmux - Terminal multiplexer
- Config: `config/tmux/tmux.conf`
- Plugin Manager: TPM (tmux plugin manager)

**Terminal Emulator:**
- Ghostty - Primary terminal
- Config: `config/ghostty/config`
- Theme: Catppuccin Frappe

## Key Dependencies

**Package Management:**
- Homebrew - macOS package manager
- Brewfile: `Brewfile`
- pnpm - Node.js package manager (preferred over npm)

**CLI Tools (from Brewfile):**

*Core:*
- `mise` - Version manager for node, go, python, etc.
- `starship` - Prompt
- `gh` - GitHub CLI
- `git` - Version control

*Modern Replacements:*
- `eza` - Better ls with icons and git status
- `bat` - Better cat with syntax highlighting
- `zoxide` - Smarter cd (z command)
- `ripgrep` (rg) - Better grep
- `fd` - Better find
- `fzf` - Fuzzy finder
- `difftastic` - Syntax-aware diffs

*Shell Enhancements:*
- `zsh-autosuggestions` - Inline suggestions from history
- `zsh-fast-syntax-highlighting` - Syntax highlighting
- `atuin` - Better shell history with sync
- `direnv` - Auto-load .envrc files

*Development:*
- `awscli` - AWS CLI
- `eksctl` - EKS CLI
- `helm` - Kubernetes package manager
- `k9s` - Kubernetes TUI
- `docker-compose` - Docker Compose
- `lazygit` - Git TUI

*Infrastructure:*
- `cloudflared` - Cloudflare tunnel
- `pulumi` - Infrastructure as code
- `coder` - Remote development

*Utilities:*
- `jq` - JSON processor
- `httpie` - HTTP client
- `btop` - System monitor
- `tlrc` - Simplified man pages (tldr in Rust)
- `ffmpeg` - Video/audio processing

## Configuration

**XDG Base Directory:**
- `XDG_CONFIG_HOME`: `~/.config`
- `XDG_DATA_HOME`: `~/.local/share`
- `XDG_CACHE_HOME`: `~/.cache`
- `XDG_STATE_HOME`: `~/.local/state`
- Set in: `home/.zshenv`

**Zsh Config:**
- `ZDOTDIR`: `$XDG_CONFIG_HOME/zsh`
- History: `$XDG_STATE_HOME/zsh/history`
- Completions cache: `$XDG_CACHE_HOME/zsh/`

**Environment Variables (set by tools):**
- Homebrew shellenv
- mise activate
- fzf key-bindings
- zoxide init
- atuin init
- direnv hook
- starship init
- 1Password CLI plugin (optional)

## GUI Applications (Casks)

**Productivity:**
- 1Password, 1Password CLI
- Arc (browser)
- Notion
- Raycast
- Rectangle (window management)

**Communication:**
- Discord
- Slack
- Telegram
- Zoom

**Development:**
- Docker
- Visual Studio Code
- Ghostty (terminal)

**Utilities:**
- Syncthing
- Tailscale (VPN)
- VLC

## Platform Requirements

**Development (macOS):**
- macOS with Apple Silicon (Homebrew at `/opt/homebrew`)
- Xcode Command Line Tools (for git, build tools)
- Nerd Fonts: JetBrains Mono, Fira Code

**Development (Linux/Remote):**
- apt, apk, dnf, or yum package manager
- curl for tool installation
- sudo access for package installation

**Managed Tool Versions (via mise):**
- Node.js: LTS
- Go: latest
- Bun: latest
- Python: latest (commented out)
- Ruby: latest (commented out)
- Rust: latest (commented out)

## Scripts

**Installation:**
- `install.sh` - Full macOS setup (Homebrew, packages, symlinks)
- `install-remote.sh` - Minimal Linux/CDE setup (CLI tools, symlinks)

**Maintenance:**
- `bin/update-all` - Update Homebrew, mise, tldr, tmux plugins
- `bin/cleanup` - Clean caches (Homebrew, npm, Docker, Xcode)

**Utilities:**
- `bin/ports` - Show processes on ports
- `bin/macos-defaults` - Configure macOS system preferences
- `bin/macos-touchid-sudo` - Enable Touch ID for sudo

---

*Stack analysis: 2026-01-17*
