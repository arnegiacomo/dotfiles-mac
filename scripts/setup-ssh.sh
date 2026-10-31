#!/usr/bin/env bash
# Creates this Mac's SSH key and registers it with GitHub for pushing and commit signing.
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
EMAIL="arnegiacomo@gmail.com"
KEY="$HOME/.ssh/id_ed25519"
SIGNERS="$DOTFILES/git/.config/git/allowed_signers"

if [[ ! -f "$KEY" ]]; then
  ssh-keygen -t ed25519 -C "$EMAIL" -f "$KEY"
  ssh-add --apple-use-keychain "$KEY"
fi

key="$(cut -d' ' -f1,2 "$KEY.pub")"
title="$(scutil --get ComputerName)"

# Listing and adding both key types needs the scopes requested at gh auth login (see README)
github_keys="$(gh ssh-key list)"
for type in authentication signing; do
  # Each line ends with the key's type
  if ! awk -v k="$key" -v t="$type" 'index($0, k) && $NF == t {found = 1} END {exit !found}' <<<"$github_keys"; then
    gh ssh-key add "$KEY.pub" --title "$title" --type "$type"
  fi
done

# Lets git verify commits signed on this Mac
if ! grep -qF "$key" "$SIGNERS"; then
  echo "$EMAIL $key" >>"$SIGNERS"
  echo "Added this key to allowed_signers. Commit that change in $DOTFILES."
fi

gh config set git_protocol ssh
git -C "$DOTFILES" remote set-url origin git@github.com:arnegiacomo/dotfiles-mac.git
