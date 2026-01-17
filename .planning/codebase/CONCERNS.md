# Codebase Concerns

**Analysis Date:** 2026-01-17

## Tech Debt

**Duplicated Backup Logic:**
- Issue: The `backup_if_exists()` function is duplicated between `install.sh` and `install-remote.sh` with slightly different implementations (one uses `rm -rf` before backup, one does not).
- Files: `install.sh` (lines 23-29), `install-remote.sh` (lines 100-105)
- Impact: Maintenance burden; behavior differs between scripts.
- Fix approach: Extract to a shared script in `bin/` or source a common functions file.

**Hardcoded Homebrew Paths:**
- Issue: Multiple files hardcode `/opt/homebrew` paths (Apple Silicon), which breaks on Intel Macs (`/usr/local/...`).
- Files: `config/zsh/.zshrc` (lines 14-16, 51-57), `config/zsh/completions.zsh` (lines 90-96)
- Impact: Dotfiles do not work on Intel Macs without modification.
- Fix approach: Use `$(brew --prefix)` dynamically or detect architecture.

**SSH Config Platform Coupling:**
- Issue: SSH config hardcodes 1Password agent path for macOS. Linux users or those not using 1Password must manually edit.
- Files: `config/ssh/config` (line 23)
- Impact: Breaks SSH agent on non-macOS systems or without 1Password.
- Fix approach: Move platform-specific settings to `config_local` or add conditional logic.

**Git Config Platform Coupling:**
- Issue: Git signing config assumes 1Password is installed at macOS path.
- Files: `config/git/config` (line 13)
- Impact: Git signing fails if 1Password is not installed or on non-macOS.
- Fix approach: Document requirement or make signing optional.

## Known Bugs

**Claude Memory Alias References Non-Existent Path:**
- Symptoms: The `claude-mem` alias references a plugin path that may not exist.
- Files: `config/zsh/aliases.zsh` (line 59)
- Trigger: Running `claude-mem` command.
- Workaround: None; the alias should be removed or the plugin installed.

**Delta Not in Brewfile:**
- Symptoms: Git config references `delta` for pager, but delta is not in Brewfile.
- Files: `config/git/config` (line 41), `Brewfile`
- Trigger: Fresh install causes git diff to fail if delta not present.
- Workaround: Install delta manually: `brew install git-delta`.

**pam_reattach Not in Brewfile:**
- Symptoms: Touch ID sudo script references `/opt/homebrew/lib/pam/pam_reattach.so` which requires separate installation.
- Files: `bin/macos-touchid-sudo` (line 11), `Brewfile`
- Trigger: Running the script fails without the pam_reattach library.
- Workaround: Install manually: `brew install pam-reattach`.

## Security Considerations

**SSH Agent Forwarding Enabled by Default:**
- Risk: Agent forwarding to all hosts (`ForwardAgent yes`) can expose SSH keys if connecting to compromised hosts.
- Files: `config/ssh/config` (line 15)
- Current mitigation: None.
- Recommendations: Enable ForwardAgent only for trusted hosts, not globally with `Host *`.

**Public Signing Key in Git Config:**
- Risk: Public key exposed in tracked file. While public keys are not secret, committing them creates a trail.
- Files: `config/git/config` (line 4)
- Current mitigation: This is an SSH public key (not private), so risk is minimal.
- Recommendations: Document that this is intentional; public keys are safe to share.

**Install Scripts Run with sudo:**
- Risk: `install-remote.sh` uses `sudo` for package installation without confirmation.
- Files: `install-remote.sh` (lines 48-78)
- Current mitigation: User must explicitly run the script.
- Recommendations: Consider prompting before sudo operations.

## Performance Bottlenecks

**Shell Startup Time:**
- Problem: Multiple `eval` commands for tool initialization (mise, starship, zoxide, atuin, direnv, pnpm completions).
- Files: `config/zsh/.zshrc`, `config/zsh/tools.zsh`, `config/zsh/completions.zsh`
- Cause: Each `eval "$(tool init zsh)"` spawns a subprocess.
- Improvement path: Use lazy loading or cache initialization output. Consider using zsh's built-in `zsh-defer` or similar plugins.

**Starship Prompt Complexity:**
- Problem: Starship config includes many language modules that run detection on every prompt.
- Files: `config/starship.toml` (lines 12-20, 85-128)
- Cause: Each module checks for project files on every prompt render.
- Improvement path: Disable unused language modules or increase `scan_timeout`.

## Fragile Areas

**Symlink Creation Order:**
- Files: `install.sh` (lines 44-68)
- Why fragile: The script removes symlinks/directories before creating new ones. If interrupted mid-execution, configs may be missing.
- Safe modification: Use atomic operations or create symlinks to temp location first.
- Test coverage: None (no automated tests).

**macOS Defaults Script:**
- Files: `bin/macos-defaults`
- Why fragile: macOS updates can change defaults keys or behaviors. Script has no validation.
- Safe modification: Test after each macOS update; add version checks.
- Test coverage: None.

**Touch ID Sudo Script:**
- Files: `bin/macos-touchid-sudo`
- Why fragile: macOS updates overwrite `/etc/pam.d/sudo`, requiring re-run. The `sed -i ''` command is macOS-specific.
- Safe modification: Check macOS version; verify pam file format before editing.
- Test coverage: None.

## Scaling Limits

**Not applicable:** This is a personal dotfiles repository; scaling is not a concern.

## Dependencies at Risk

**pnpm Hardcoded:**
- Risk: All npm aliases assume pnpm. Users preferring npm/yarn must modify.
- Impact: Cannot use standard npm workflows.
- Migration plan: Create alias sets for each package manager; detect installed manager.

**1Password SSH Agent:**
- Risk: SSH and Git signing depend on 1Password being installed and configured.
- Impact: SSH/Git operations fail without 1Password.
- Migration plan: Document as requirement or provide fallback to system SSH agent.

**Nerd Fonts Required:**
- Risk: Terminal and prompt use Nerd Font glyphs; display breaks without correct fonts.
- Impact: Icons show as boxes/question marks.
- Migration plan: Fonts are in Brewfile; document manual installation for non-Homebrew systems.

## Missing Critical Features

**No Linux Support:**
- Problem: Full install script is macOS-only. Remote script has limited Linux support.
- Blocks: Cannot use full dotfiles setup on Linux workstations.

**No Uninstall Script:**
- Problem: No way to cleanly remove dotfiles and restore backups.
- Blocks: Clean migration or removal.

**No Dry-Run Mode:**
- Problem: Install scripts make changes immediately without preview.
- Blocks: Testing changes safely before applying.

## Test Coverage Gaps

**No Automated Tests:**
- What's not tested: All shell scripts, configurations, and install procedures.
- Files: All files in `bin/`, `install.sh`, `install-remote.sh`
- Risk: Breaking changes go unnoticed until manual testing.
- Priority: Low (personal dotfiles; manual testing is acceptable).

**No Shellcheck Linting:**
- What's not tested: Shell scripts are not linted for common errors.
- Files: `bin/*`, `install.sh`, `install-remote.sh`, `config/zsh/*.zsh`
- Risk: Subtle bugs, portability issues, or bad practices.
- Priority: Medium (easy to add with CI).

---

*Concerns audit: 2026-01-17*
