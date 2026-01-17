# Codebase Structure

**Analysis Date:** 2026-01-17

## Directory Layout

```
dotfiles/
├── bin/                    # Executable utility scripts (added to PATH)
├── config/                 # Application configs (symlinked to ~/.config)
│   ├── claude/            # Claude Code settings and commands
│   │   └── commands/      # Custom Claude commands
│   ├── ghostty/           # Terminal emulator config
│   │   └── themes/        # Color themes
│   ├── git/               # Git configuration
│   ├── mise/              # Version manager config
│   ├── ssh/               # SSH configuration
│   ├── tmux/              # Tmux multiplexer config
│   └── zsh/               # Zsh shell config (ZDOTDIR)
├── home/                   # Files symlinked directly to $HOME
├── .planning/             # GSD planning documents
│   └── codebase/          # Codebase analysis docs
├── .claude/               # Local Claude Code settings
├── Brewfile               # Homebrew package manifest
├── install.sh             # Full macOS installation script
├── install-remote.sh      # Minimal Linux/CDE installation script
└── README.md              # Documentation
```

## Directory Purposes

**`bin/`:**
- Purpose: User-facing utility scripts
- Contains: Shell scripts for maintenance tasks
- Key files: `cleanup`, `update-all`, `ports`, `macos-defaults`, `macos-touchid-sudo`

**`config/`:**
- Purpose: Application configuration files
- Contains: Subdirectories per tool, symlinked to `~/.config/`
- Key files: See individual tool directories below

**`config/zsh/`:**
- Purpose: Complete zsh configuration (ZDOTDIR)
- Contains: Main rc file and modular includes
- Key files: `.zshrc`, `aliases.zsh`, `functions.zsh`, `completions.zsh`, `tools.zsh`

**`config/git/`:**
- Purpose: Git configuration
- Contains: Global git config and ignores
- Key files: `config`, `ignore`

**`config/tmux/`:**
- Purpose: Tmux terminal multiplexer configuration
- Contains: Main tmux config with plugins
- Key files: `tmux.conf`

**`config/starship.toml`:**
- Purpose: Starship prompt configuration
- Contains: Prompt format, colors, icons
- Key files: Single file `starship.toml`

**`config/ghostty/`:**
- Purpose: Ghostty terminal emulator configuration
- Contains: Main config and color themes
- Key files: `config`, `themes/catppuccin-mocha`, `themes/catppuccin-frappe`

**`config/claude/`:**
- Purpose: Claude Code AI assistant configuration
- Contains: Settings, custom commands, preferences
- Key files: `settings.json`, `CLAUDE.md`, `commands/*.md`

**`config/mise/`:**
- Purpose: mise version manager configuration
- Contains: Default tool versions
- Key files: `config.toml`

**`config/ssh/`:**
- Purpose: SSH client configuration
- Contains: Base SSH config (machine-specific goes elsewhere)
- Key files: `config`

**`home/`:**
- Purpose: Files that must live directly in $HOME
- Contains: Bootstrap file for zsh
- Key files: `.zshenv`

## Key File Locations

**Entry Points:**
- `home/.zshenv`: Zsh bootstrap, sets XDG vars and ZDOTDIR
- `config/zsh/.zshrc`: Main interactive shell configuration
- `install.sh`: Full macOS setup script
- `install-remote.sh`: Minimal Linux/CDE setup script

**Configuration:**
- `Brewfile`: Homebrew packages (taps, brews, casks)
- `config/git/config`: Git user, aliases, delta, difftastic
- `config/mise/config.toml`: Default language versions
- `config/starship.toml`: Prompt customization

**Shell Modules:**
- `config/zsh/aliases.zsh`: Command shortcuts
- `config/zsh/functions.zsh`: Custom shell functions
- `config/zsh/completions.zsh`: Tab completion, history, key bindings
- `config/zsh/tools.zsh`: Modern CLI tool initialization

**Utilities:**
- `bin/cleanup`: Clean caches (Homebrew, npm, Docker, etc.)
- `bin/update-all`: Update all tools (brew, mise, tldr, tmux)
- `bin/ports`: Show listening ports
- `bin/macos-defaults`: Configure macOS system preferences
- `bin/macos-touchid-sudo`: Enable Touch ID for sudo

## Naming Conventions

**Files:**
- Shell configs: `*.zsh` extension in zsh directory
- Config files: Named per tool convention (`config`, `config.toml`, etc.)
- Scripts: Lowercase with hyphens (e.g., `update-all`, `macos-defaults`)

**Directories:**
- Tool directories: Lowercase, single word (e.g., `git`, `zsh`, `tmux`)
- Multi-word directories: Lowercase with hyphens if needed

## Where to Add New Code

**New Shell Alias:**
- Add to: `config/zsh/aliases.zsh`
- Format: `alias name='command'`

**New Shell Function:**
- Add to: `config/zsh/functions.zsh`
- Format: `funcname() { ... }`

**New CLI Tool Integration:**
- Add to: `config/zsh/tools.zsh`
- Pattern: Check existence, then initialize with conditional

**New Homebrew Package:**
- Add to: `Brewfile`
- Run: `brew bundle`

**New Language Version:**
- Edit: `config/mise/config.toml`
- Run: `mise install`

**New Utility Script:**
- Add to: `bin/`
- Make executable: `chmod +x bin/scriptname`
- Available via PATH automatically

**New Application Config:**
- Create: `config/appname/` directory
- Add symlink in: `install.sh` (and `install-remote.sh` if needed)

**New Claude Command:**
- Add to: `config/claude/commands/`
- Format: Markdown file with frontmatter

## Special Directories

**`.git/`:**
- Purpose: Git repository metadata
- Generated: Yes
- Committed: No (tracked by git itself)

**`.planning/`:**
- Purpose: GSD planning and codebase analysis
- Generated: By GSD commands
- Committed: Yes

**`.claude/`:**
- Purpose: Local Claude Code settings
- Generated: By Claude Code
- Committed: No (contains `settings.local.json`)

**`~/.tmux/plugins/`:**
- Purpose: Tmux plugins (installed by TPM)
- Generated: Yes (by install script)
- Committed: No (external to this repo)

---

*Structure analysis: 2026-01-17*
