# Dotfiles

Personal dotfiles using XDG Base Directory Specification.

## Structure

```
dotfiles/
├── install.sh              # Full install (macOS)
├── install-remote.sh       # Minimal install (CDEs)
├── Brewfile                # Homebrew packages
├── config/
│   ├── zsh/               # Zsh config (ZDOTDIR)
│   │   ├── .zshrc
│   │   ├── aliases.zsh
│   │   └── functions.zsh
│   ├── git/config         # Git config
│   ├── mise/config.toml   # mise version manager
│   └── starship.toml      # Starship prompt
└── home/
    └── .zshenv            # Bootstrap (sets ZDOTDIR)
```

## Installation

### Full Install (macOS)

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

### Remote/CDE Install (Minimal)

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install-remote.sh
```

## Tools

- **Shell**: zsh with XDG structure
- **Prompt**: [Starship](https://starship.rs/)
- **Version Manager**: [mise](https://mise.jdx.dev/) (node, go, python, etc.)
- **Package Manager**: Homebrew (macOS)

## Manual Setup (not in dotfiles)

These files contain secrets or machine-specific config - set up manually:

```bash
# NPM tokens (if needed)
~/.npmrc

# AWS - use SSO, no credentials file needed
aws sso login

# SSH - copy the base config, then add machine-specific hosts
cp ~/dotfiles/config/ssh/config ~/.ssh/config

```

## Customization

Edit files directly in `~/dotfiles/config/` - they're symlinked to `~/.config/`.

### Add aliases

Edit `~/dotfiles/config/zsh/aliases.zsh`

### Change prompt

Edit `~/dotfiles/config/starship.toml`

### Add Homebrew packages

Edit `~/dotfiles/Brewfile` then run `brew bundle`

### Change language versions

Edit `~/dotfiles/config/mise/config.toml` then run `mise install`
