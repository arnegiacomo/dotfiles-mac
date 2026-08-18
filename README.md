# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's included

| Package | Contents |
|---------|----------|
| `zsh`   | `.zshrc`, `.zshenv`, `.zprofile` |
| `nvim`  | Neovim config (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)) with LSP for Java, TypeScript/JavaScript |
| `git`   | Global gitignore |
| `gh`    | GitHub CLI config |
| `claude` | Global `CLAUDE.md` for Claude Code |

## Setup

```bash
git clone git@github.com:arnegiacomo/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

### macOS

```bash
brew install stow
```

### Ubuntu / Pop!_OS

```bash
sudo apt install stow
```

### Install packages

```bash
# Install all
stow zsh nvim git gh claude

# Or pick individual packages
stow nvim
```

## Not included (machine-specific)

- `~/.secrets` — API tokens, sourced from `.zshenv`
- `~/.gitconfig` — git user/signing config (OS-specific paths)
