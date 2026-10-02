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
| `agents` | Shared global instructions and skills for Claude Code, OpenCode, and Codex CLI, plus Claude Code settings. The `hunk-review` skill needs [Hunk](https://hunk.dev) (`brew install hunk`) |
| `opencode` | OpenCode configuration |
| `vscode` | VS Code user settings |
| `ssh`   | `~/.ssh/config` (keys are gitignored) |

`Brewfile` lists the macOS tools, apps and VS Code extensions.

## Setup

```bash
# Clone to ~/dotfiles: topgrade's config expects that path
git clone git@github.com:arnegiacomo/dotfiles-mac.git ~/dotfiles
~/dotfiles/scripts/bootstrap-mac.sh     # asks y/n for each step, "a" accepts the rest
~/dotfiles/scripts/bootstrap-mac.sh -y  # accept everything
```

Installs Homebrew, the `Brewfile` picks and Claude Code, stows the packages, then applies the macOS settings from `scripts/macos-defaults.sh`.

### Stow packages by hand

```bash
cd ~/dotfiles
stow zsh nvim git gh starship topgrade
stow --no-folding agents opencode ghostty vscode ssh
```

## Not included (machine-specific)

- `~/.secrets` — API tokens, sourced from `.zshenv`
- `~/.gitconfig` — git user/signing config (OS-specific paths)
