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

echo "==> Stow packages"
for pkg in zsh nvim git gh starship topgrade-mac; do
  if ask "Stow $pkg?"; then stow -d "$DOTFILES" -t "$HOME" "$pkg"; fi
done
# --no-folding links single files, so apps never write caches, or ssh-keygen keys, into the repo
for pkg in agents opencode ghostty ghostty-mac vscode ssh; do
  if ask "Stow $pkg?"; then stow --no-folding -d "$DOTFILES" -t "$HOME" "$pkg"; fi
done

echo "Done. Open a new terminal to load the shell config."
