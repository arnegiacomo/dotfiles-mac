# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package | Contents |
|---------|----------|
| `zsh`   | `.zshrc`, `.zshenv`, `.zprofile` |
| `nvim`  | Neovim config (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)) with LSP for Java, TypeScript/JavaScript |
| `git`   | Global gitignore |
| `gh`    | GitHub CLI config |
| `agents` | Shared global instructions and skills for Claude Code, OpenCode, and Codex CLI, plus Claude Code settings. The `hunk-review` skill needs [Hunk](https://hunk.dev) (`brew install hunk`) |
| `opencode` | OpenCode configuration |
| `vscode` | VS Code user settings |
| `ssh`   | `~/.ssh/config` (keys are gitignored) |

`Brewfile` lists the macOS tools, apps and VS Code extensions.

## Setup

```bash
git clone git@github.com:arnegiacomo/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### macOS

```bash
./scripts/bootstrap-mac.sh     # asks y/n for each install and package, "a" accepts the rest
./scripts/bootstrap-mac.sh -y  # accept everything
```

Installs Homebrew, the `Brewfile` picks and Claude Code, then stows the packages. The steps below are for Linux, or for picking packages by hand.

### Ubuntu / Pop!_OS

```bash
sudo apt install stow
```

### Install packages

```bash
# Install all
stow zsh nvim git gh
stow --no-folding agents opencode vscode ssh

# Or pick individual packages
stow nvim
```

## Not included (machine-specific)

- `~/.secrets` — API tokens, sourced from `.zshenv`
- `~/.gitconfig` — git user/signing config (OS-specific paths)
