# =============================================================================
# Brewfile - Homebrew Bundle (cross-platform CLI tools)
# Install with: brew bundle --file=~/dotfiles/Brewfile
#
# This file is shared by macOS and remote Linux. GUI apps / fonts live in
# Brewfile.macos and are only installed on macOS.
# =============================================================================

# -----------------------------------------------------------------------------
# Taps
# -----------------------------------------------------------------------------
tap "hashicorp/tap"   # current terraform (homebrew-core's is frozen at 1.5.7)

# -----------------------------------------------------------------------------
# Core CLI Tools
# -----------------------------------------------------------------------------
brew "mise"           # Version manager (node, go, python, etc.)
brew "starship"       # Prompt
brew "gh"             # GitHub CLI
brew "git"            # Version control (brew version is newer)

# Shell
brew "zsh-autosuggestions"
brew "zsh-fast-syntax-highlighting"

# Search & Navigation
brew "ripgrep"        # Better grep (rg)
brew "fd"             # Better find
brew "fzf"            # Fuzzy finder
brew "lazygit"        # Git TUI

# Modern CLI replacements
brew "eza"            # Better ls with icons & git
brew "bat"            # Better cat with syntax highlighting
brew "zoxide"         # Smarter cd (z command)
brew "tlrc"           # Simplified man pages (tldr)

# Shell enhancements
brew "atuin"          # Better shell history with sync
brew "direnv"         # Auto-load .envrc files
brew "tmux"           # Terminal multiplexer

# Utilities
brew "jq"             # JSON processor
brew "difftastic"     # Syntax-aware diffs
brew "btop"           # System monitor
brew "httpie"         # HTTP client

# -----------------------------------------------------------------------------
# Development Tools
# -----------------------------------------------------------------------------
brew "awscli"         # AWS CLI
brew "eksctl"         # EKS CLI
brew "docker-compose" # Docker Compose
brew "pnpm"           # Fast npm alternative

# Kubernetes
brew "kubernetes-cli" # kubectl
brew "helm"           # Kubernetes package manager
brew "k9s"            # Kubernetes TUI

# Infrastructure as code
brew "hashicorp/tap/terraform" # Terraform
brew "pulumi"         # Pulumi IaC

# Cloud & Infrastructure
brew "cloudflared"    # Cloudflare tunnel
brew "coder"          # Remote development

# AI Tools
brew "aichat"         # AI chat CLI
brew "herdr"          # Agent multiplexer in the terminal (installs its Claude hook)

# Media
brew "ffmpeg"         # Video/audio processing
