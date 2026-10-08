# dotfiles-mac
My macOS setup - shell, editor, terminal and coding agent config, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's in it

- `zsh` - `.zshrc`, `.zshenv`, `.zprofile`
- `nvim` - Neovim, based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- `ghostty`, `herdr`, `hunk`, `starship`, `topgrade`, `opencode`, `vscode` - config for each
- `git`, `gh`, `ssh` - git and GitHub CLI config, `~/.ssh/config` (never keys)
- `agents` - shared instructions and skills for Claude Code, Codex and OpenCode, plus Claude Code settings and a hook that sends clickable desktop notifications for Claude sessions in herdr

`Brewfile` lists the tools, apps and VS Code extensions. The herdr and hunk-review skills come from the installed tools (`herdr --skill`, and a copy of the skill shipped with hunk) on bootstrap and after every topgrade run, so they're gitignored.

## Setup

On a fresh Mac. The SSH key step uploads the key with `gh`, so log in to GitHub first:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install gh
gh auth login                                      # GitHub.com, HTTPS, log in with a browser
gh repo clone arnegiacomo/dotfiles-mac ~/dotfiles  # topgrade's config expects ~/dotfiles
~/dotfiles/scripts/bootstrap-mac.sh                # asks y/n for each step, "a" accepts the rest
```

Installs the `Brewfile` picks and Claude Code, stows the packages, sets up the SSH key for pushing and commit signing, and applies the macOS settings. `-y` accepts everything. If the SSH step adds a key to `allowed_signers`, commit it. For the herdr notification hook, allow terminal-notifier in System Settings → Notifications after its first notification.

Or stow by hand:

```bash
cd ~/dotfiles
stow zsh nvim git gh starship topgrade
stow --no-folding agents opencode ghostty herdr hunk vscode ssh
```

## Not included

- `~/.secrets` - API tokens, sourced from `.zshenv`
- `~/.gitconfig.local` - per-machine git overrides, included from the git config
