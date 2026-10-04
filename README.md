# dotfiles-mac

Personal macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package | Contents |
|---------|----------|
| `zsh`   | `.zshrc`, `.zshenv`, `.zprofile` |
| `nvim`  | Neovim config (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)) with LSP for Java, TypeScript/JavaScript |
| `git`   | Global gitignore |
| `gh`    | GitHub CLI config |
| `ghostty` | Ghostty config and keybinds |
| `starship` | Starship prompt |
| `topgrade` | Topgrade config |
| `agents` | Shared global instructions and skills for Claude Code, OpenCode, and Codex CLI, plus Claude Code settings. The `hunk-review` skill needs [Hunk](https://hunk.dev) (`brew install hunk`). The `SessionStart` hook comes from `herdr integration install claude`, and the `herdr` skill from `herdr --skill` |
| `herdr` | [herdr](https://herdr.dev) config |
| `opencode` | OpenCode configuration |
| `vscode` | VS Code user settings |
| `ssh`   | `~/.ssh/config` (keys are gitignored) |

`Brewfile` lists the macOS tools, apps and VS Code extensions.

## Setup

On a fresh Mac, paste this into Terminal. The repo is private, so the first steps log in to GitHub before cloning.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install gh
gh auth login                                      # GitHub.com, HTTPS, log in with a browser
gh repo clone arnegiacomo/dotfiles-mac ~/dotfiles  # topgrade's config expects ~/dotfiles
~/dotfiles/scripts/bootstrap-mac.sh                # asks y/n for each step, "a" accepts the rest
```

`bootstrap-mac.sh -y` accepts everything. It installs the `Brewfile` picks and Claude Code, stows the packages, sets up this Mac's SSH key for pushing and commit signing (`scripts/setup-ssh.sh`), then applies the macOS settings from `scripts/macos-defaults.sh`.

When the SSH step adds a new key to `allowed_signers`, commit that change.

### Stow packages by hand

```bash
cd ~/dotfiles
stow zsh nvim git gh starship topgrade
stow --no-folding agents opencode ghostty herdr vscode ssh
```

## Not included (machine-specific)

- `~/.secrets` — API tokens, sourced from `.zshenv`
- `~/.gitconfig` — git user/signing config (OS-specific paths)
