# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A [chezmoi](https://chezmoi.io)-managed dotfiles repository for macOS. Chezmoi translates files in this source directory to the home directory using naming conventions.

## Chezmoi File Naming Conventions

- `dot_foo` → `~/.foo` (e.g., `dot_zshrc` → `~/.zshrc`)
- `dot_config/bar` → `~/.config/bar`
- `*.tmpl` → processed as Go templates before applying
- `run_onchange_*.sh.tmpl` → script runs whenever its content changes
- `symlink_foo` → creates a symlink at the target path

## Common Commands

```sh
# Apply changes from source to home directory
chezmoi apply

# Preview what would change
chezmoi diff

# Edit a managed file (opens in $EDITOR, then applies)
chezmoi edit ~/.zshrc

# Re-run all run_onchange scripts (e.g., after adding a new brew package)
chezmoi apply --force

# Add a new dotfile to be managed
chezmoi add ~/.config/somefile
```

## Architecture

### External Dependencies
`.chezmoiexternal.toml` pulls the Neovim config from a separate git repo (`https://github.com/abc10605/neovim-config.git`) into `~/.config/nvim`. It refreshes weekly.

### Homebrew Automation
`run_onchange_brew-bundle.sh.tmpl` automatically runs `brew bundle` on macOS whenever `Brewfile` changes. To add packages, edit `Brewfile` and run `chezmoi apply`.

### Templates
Files ending in `.tmpl` use Go template syntax. The git config (`dot_config/git/config.tmpl`) uses `{{ if stat "/Applications/1Password.app" }}` to conditionally enable 1Password SSH signing on macOS. Lazygit config uses `{{ if lookPath "delta" }}` to conditionally configure the delta pager.

### 1Password Integration
- SSH commit signing via `op-ssh-sign` (macOS only, requires 1Password.app)
- SSH agent socket at `~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock`
- The `dot_zshrc` exports `SSH_AUTH_SOCK` pointing to that socket
