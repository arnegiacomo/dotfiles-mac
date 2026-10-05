# dotfiles-mac
My macOS setup - shell, editor, terminal and coding agent config, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's in it

- `zsh` - `.zshrc`, `.zshenv`, `.zprofile`
- `nvim` - Neovim, based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- `ghostty`, `herdr`, `hunk`, `starship`, `topgrade`, `opencode`, `vscode` - config for each
- `git`, `gh`, `ssh` - git and GitHub CLI config, `~/.ssh/config` (never keys)
- `agents` - shared instructions and skills for Claude Code, Codex and OpenCode, plus Claude Code settings

`Brewfile` lists the tools, apps and VS Code extensions. The herdr skill is generated from the installed herdr (`herdr --skill`) on bootstrap and after every topgrade run, so it's gitignored.

## Setup

On a fresh Mac. The repo is private, so log in to GitHub before cloning:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install gh
gh auth login                                      # GitHub.com, HTTPS, log in with a browser
gh repo clone arnegiacomo/dotfiles-mac ~/dotfiles  # topgrade's config expects ~/dotfiles
~/dotfiles/scripts/bootstrap-mac.sh                # asks y/n for each step, "a" accepts the rest
```

Installs the `Brewfile` picks and Claude Code, stows the packages, sets up the SSH key for pushing and commit signing, and applies the macOS settings. `-y` accepts everything. If the SSH step adds a key to `allowed_signers`, commit it.

Or stow by hand:

```bash
cd ~/dotfiles
stow zsh nvim git gh starship topgrade
stow --no-folding agents opencode ghostty herdr hunk vscode ssh
```

## Not included

- `~/.secrets` - API tokens, sourced from `.zshenv`
- `~/.gitconfig.local` - per-machine git overrides, included from the git config
