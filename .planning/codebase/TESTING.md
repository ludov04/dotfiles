# Testing Patterns

**Analysis Date:** 2026-01-17

## Test Framework

**Runner:**
- No automated testing framework detected
- This is a dotfiles/configuration repository

**Assertion Library:**
- Not applicable

**Run Commands:**
```bash
# No test commands - manual testing only
```

## Test File Organization

**Location:**
- No test files present

**Naming:**
- Not applicable

**Structure:**
- Not applicable

## Manual Testing Approach

This repository uses manual verification rather than automated tests. The nature of dotfiles (shell configuration, symlink management, tool setup) makes them suited for manual testing on actual systems.

### Testing Install Scripts

**Full Install (`install.sh`):**
```bash
# Test on macOS
cd ~/dotfiles
./install.sh

# Verify symlinks created
ls -la ~/.zshenv
ls -la ~/.config/zsh
ls -la ~/.config/git

# Verify shell works
exec zsh
```

**Remote Install (`install-remote.sh`):**
```bash
# Test on Linux/container environment
cd ~/dotfiles
./install-remote.sh

# Verify tools installed
command -v starship
command -v eza
command -v zoxide
```

### Testing Utility Scripts

**`bin/cleanup`:**
```bash
# Test individual sections
brew cleanup -s
pnpm store prune
docker system prune -f
```

**`bin/update-all`:**
```bash
# Run and verify no errors
./bin/update-all
```

**`bin/ports`:**
```bash
# Test with and without argument
./bin/ports
./bin/ports 3000
```

**`bin/macos-defaults`:**
```bash
# Run and verify settings applied
./bin/macos-defaults

# Check specific defaults
defaults read com.apple.finder AppleShowAllFiles
defaults read com.apple.dock autohide
```

### Testing Shell Functions

**From `config/zsh/functions.zsh`:**

```bash
# Test mkcd
mkcd /tmp/test-dir
pwd  # Should be /tmp/test-dir

# Test ff (find file)
ff zshrc  # Should find .zshrc

# Test extract (with various archives)
extract test.tar.gz
extract test.zip

# Test node-modules
node-modules  # Should list node_modules with sizes

# Test pnpm-run (in a project with package.json)
pnpm-run  # Should show fzf selector
```

### Testing Aliases

**Verify alias expansion:**
```bash
# Check alias definitions
alias gs  # Should show: git status
alias ll  # Should show: eza -l --icons...

# Test they work
gs  # Should run git status
ll  # Should show detailed listing with icons
```

## Smoke Testing Checklist

When making changes, verify these core functions work:

**Shell Startup:**
- [ ] New terminal opens without errors
- [ ] Prompt (starship) displays correctly
- [ ] Autosuggestions work (start typing, see gray suggestion)
- [ ] Syntax highlighting works (commands colored)
- [ ] Tab completion works

**Navigation:**
- [ ] `z` (zoxide) navigates to frecent directories
- [ ] `ls`, `ll`, `la` use eza with icons
- [ ] `cat` uses bat with syntax highlighting
- [ ] Ctrl+R opens fzf history search
- [ ] Ctrl+T opens fzf file search

**Git:**
- [ ] `gs` shows git status
- [ ] `gd` shows diffs (with delta)
- [ ] `gl` shows log

**Package Management:**
- [ ] `pn`, `pi`, `pd` work for pnpm

**tmux:**
- [ ] `tmux` starts without errors
- [ ] Prefix (Ctrl+a) works
- [ ] Mouse support works
- [ ] Session restore works after tmux restart

## Coverage

**Requirements:** None enforced

**View Coverage:** Not applicable

## Test Types

**Unit Tests:**
- Not implemented
- Would require shell testing frameworks like bats-core or shunit2

**Integration Tests:**
- Not implemented
- Install scripts serve as implicit integration tests

**E2E Tests:**
- Not implemented
- Manual testing on fresh systems

## Potential Testing Improvements

If automated testing were added, consider:

**Shell Script Testing with bats-core:**
```bash
# Example test structure
# test/install.bats

@test "install.sh creates symlinks" {
    run ./install.sh
    [ -L "$HOME/.zshenv" ]
    [ -L "$HOME/.config/zsh" ]
}

@test "backup_if_exists backs up files" {
    touch /tmp/test_backup
    backup_if_exists /tmp/test_backup
    [ -f "/tmp/test_backup.backup" ]
}
```

**CI Testing:**
```yaml
# Example GitHub Actions
jobs:
  test:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v4
      - name: Run install
        run: ./install.sh
      - name: Verify symlinks
        run: |
          test -L ~/.zshenv
          test -L ~/.config/zsh
```

## Current Verification Methods

**Linting:**
- No shellcheck or other linting configured
- Consider adding: `shellcheck *.sh bin/*`

**Syntax Checking:**
```bash
# Manual syntax check for bash scripts
bash -n install.sh
bash -n install-remote.sh

# Manual syntax check for zsh
zsh -n config/zsh/.zshrc
```

**Dry Run:**
- Install scripts do not have dry-run mode
- Changes are made directly to filesystem

---

*Testing analysis: 2026-01-17*
