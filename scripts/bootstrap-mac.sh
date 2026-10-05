#!/usr/bin/env bash
# Sets up a new Mac from these dotfiles. Asks before every install and stow; pass -y to accept everything.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
accept_all=false
[[ "${1:-}" == "-y" ]] && accept_all=true

# y/n prompt; "a" accepts this and every later prompt.
# Reads from /dev/tty because stdin is taken by the Brewfile loop.
ask() {
  $accept_all && return 0
  local reply
  while true; do
    read -rp "$1 [y/n/a] " reply </dev/tty
    case "$reply" in
      y) return 0 ;;
      n) return 1 ;;
      a) accept_all=true; return 0 ;;
    esac
  done
}

if ! command -v brew >/dev/null; then
  ask "Install Homebrew?" || exit 1
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Brewfile"
picked="$(mktemp)"
while IFS= read -r line; do
  if ask "$line"; then echo "$line" >>"$picked"; fi
done < <(grep -E '^(tap|brew|cask|mas|vscode) ' "$DOTFILES/Brewfile")
brew bundle --file "$picked" || echo "Some installs failed, see above."

# Native installer instead of the cask, since it keeps itself updated
if ! command -v claude >/dev/null && ask "Install Claude Code (native installer)?"; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# The herdr skill is generated, not committed, and must exist before agents is stowed; topgrade regenerates it after upgrades
if command -v herdr >/dev/null; then
  mkdir -p "$DOTFILES/agents/.agents/skills/herdr"
  herdr --skill > "$DOTFILES/agents/.agents/skills/herdr/SKILL.md"
fi

echo "==> Stow packages"
for pkg in zsh nvim git gh starship topgrade; do
  if ask "Stow $pkg?"; then stow -d "$DOTFILES" -t "$HOME" "$pkg"; fi
done
# --no-folding links single files, so apps never write caches, or ssh-keygen keys, into the repo
for pkg in agents opencode ghostty herdr hunk vscode ssh; do
  if ask "Stow $pkg?"; then stow --no-folding -d "$DOTFILES" -t "$HOME" "$pkg"; fi
done

# settings.json already holds the hook entry; this writes the hook script it points to
if command -v herdr >/dev/null && ask "Install herdr's Claude Code hook?"; then herdr integration install claude; fi

if ask "Set up this Mac's SSH key for GitHub?"; then "$DOTFILES/scripts/setup-ssh.sh"; fi

if ask "Apply macOS settings (Dock, Finder, dark mode)?"; then "$DOTFILES/scripts/macos-defaults.sh"; fi

echo "Done. Open a new terminal to load the shell config."
