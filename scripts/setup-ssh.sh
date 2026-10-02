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

# Uploading signing keys needs a scope gh doesn't ask for at login
gh auth refresh -h github.com -s admin:public_key,admin:ssh_signing_key
title="$(scutil --get ComputerName)"
gh ssh-key add "$KEY.pub" --title "$title" --type authentication || echo "Key already on GitHub for pushing."
gh ssh-key add "$KEY.pub" --title "$title" --type signing || echo "Key already on GitHub for signing."

# Lets git verify commits signed on this Mac
key="$(cut -d' ' -f1,2 "$KEY.pub")"
if ! grep -qF "$key" "$SIGNERS"; then
  echo "$EMAIL $key" >>"$SIGNERS"
  echo "Added this key to allowed_signers. Commit that change in $DOTFILES."
fi

gh config set git_protocol ssh
git -C "$DOTFILES" remote set-url origin git@github.com:arnegiacomo/dotfiles-mac.git
