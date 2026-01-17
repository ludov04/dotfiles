# External Integrations

**Analysis Date:** 2026-01-17

## APIs & External Services

**GitHub:**
- Tool: `gh` (GitHub CLI)
- SSH: Configured in `config/ssh/config`
- Signing: Commits signed with SSH key via 1Password

**AWS:**
- Tool: `awscli`
- EKS: `eksctl` for EKS management
- Auth: Managed externally (credentials not in dotfiles)

**Kubernetes:**
- Tools: `helm`, `k9s`
- Config: Managed externally (`~/.kube/config`)

**Cloudflare:**
- Tool: `cloudflared` for tunnels
- Auth: Managed externally

**Coder:**
- Tool: `coder` CLI for remote development environments
- Auth: Managed externally

## Data Storage

**Databases:**
- None configured in dotfiles
- Tools like psql/mysql expected to be installed per-project

**File Storage:**
- Syncthing for file sync (GUI cask)
- Local filesystem only for dotfiles

**Caching:**
- Zsh completion cache: `$XDG_CACHE_HOME/zsh/zcompcache`
- tmux resurrect: `~/.local/share/tmux/resurrect`

## Authentication & Identity

**SSH:**
- Config: `config/ssh/config`
- Agent: 1Password SSH Agent
- Agent socket: `~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock`
- ForwardAgent: enabled

**Git Signing:**
- Method: SSH key signing
- Key: ed25519 stored in 1Password
- Sign program: `/Applications/1Password.app/Contents/MacOS/op-ssh-sign`
- Config: `config/git/config`

**1Password:**
- Apps: 1Password, 1Password CLI
- SSH Agent: Provides SSH keys
- Git signing: Signs commits
- CLI plugins: `~/.config/op/plugins.sh` (if exists)

## Shell History Sync

**Atuin:**
- Purpose: Shell history sync across machines
- Init: `atuin init zsh --disable-up-arrow`
- Config: Managed externally

## Monitoring & Observability

**Error Tracking:**
- None configured

**Logs:**
- Shell history: `$XDG_STATE_HOME/zsh/history` (50000 lines)
- tmux logs: None configured

**System Monitoring:**
- `btop` - Interactive system monitor
- `k9s` - Kubernetes monitoring

## CI/CD & Deployment

**Hosting:**
- Not applicable (dotfiles repo)

**CI Pipeline:**
- None configured

**Infrastructure as Code:**
- `pulumi` installed but config external

## Environment Configuration

**Required env vars:**
- None strictly required (graceful fallbacks throughout)

**Optional env vars:**
- `DOTFILES` - Override dotfiles location (default: `$HOME/dotfiles`)
- XDG vars set in `home/.zshenv`

**Secrets location:**
- SSH keys: 1Password
- API credentials: External (not in dotfiles)
- Git signing key: 1Password

## Claude Code Integration

**Config Location:** `config/claude/`

**Files:**
- `CLAUDE.md` - Personal development preferences
- `settings.json` - Claude Code settings
- `commands/commit-and-push.md` - Custom command
- `commands/review.md` - Custom command

**Plugins:**
- `frontend-design@claude-plugins-official`
- `typescript-lsp@claude-plugins-official`
- `claude-mem@thedotmack`

**Hooks:**
- SessionStart: `~/.claude/hooks/gsd-check-update.js`
- StatusLine: `~/.claude/hooks/statusline.js`

## Directory Auto-Loading

**direnv:**
- Enabled: `eval "$(direnv hook zsh)"`
- Purpose: Auto-load `.envrc` files in project directories
- Usage: Create `.envrc` in project dirs to set env vars automatically

## VPN & Networking

**Tailscale:**
- Installed as cask
- Provides mesh VPN
- Config: Managed externally

## tmux Plugins (via TPM)

**Installed:**
- `tmux-plugins/tpm` - Plugin manager
- `tmux-plugins/tmux-sensible` - Sensible defaults
- `tmux-plugins/tmux-resurrect` - Save/restore sessions
- `tmux-plugins/tmux-continuum` - Auto-save sessions
- `tmux-plugins/tmux-yank` - Better copy/paste

**Resurrect Settings:**
- Save interval: 15 minutes
- Auto-restore: enabled
- Capture pane contents: enabled
- Save location: `~/.local/share/tmux/resurrect`

## Webhooks & Callbacks

**Incoming:**
- None

**Outgoing:**
- None

## Tool-Specific Integrations

**fzf + bat:**
- Preview files with syntax highlighting
- `FZF_CTRL_T_OPTS`: bat preview

**fzf + eza:**
- Preview directories with tree view
- `FZF_ALT_C_OPTS`: eza tree preview

**fzf + fd:**
- Use fd for file/directory discovery
- `FZF_DEFAULT_COMMAND`: fd for files
- `FZF_ALT_C_COMMAND`: fd for directories

**bat + man:**
- Colored man pages via `MANPAGER`

**git + delta:**
- Side-by-side diffs with syntax highlighting
- Navigate diffs with n/N
- Config: `config/git/config`

**git + difftastic:**
- Syntax-aware diffs via `git difftool`
- Config: `config/git/config`

---

*Integration audit: 2026-01-17*
