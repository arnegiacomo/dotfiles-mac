#!/usr/bin/env bash
# Lets sudo use Touch ID. sudo_local survives macOS updates, unlike /etc/pam.d/sudo.
set -euo pipefail

REATTACH="/opt/homebrew/lib/pam/pam_reattach.so"

# pam_reattach makes Touch ID work inside multiplexers like herdr
{
  [[ -f "$REATTACH" ]] && echo "auth       optional       $REATTACH ignore_ssh"
  echo "auth       sufficient     pam_tid.so"
} | sudo tee /etc/pam.d/sudo_local >/dev/null
