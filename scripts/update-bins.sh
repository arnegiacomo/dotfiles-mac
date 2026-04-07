#!/usr/bin/env bash
set -e

echo "==> Updating lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep tag_name | cut -d'"' -f4 | sed 's/v//')
curl -sLo /tmp/lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -C /tmp -xzf /tmp/lazygit.tar.gz lazygit
sudo install /tmp/lazygit /usr/local/bin
echo "    lazygit ${LAZYGIT_VERSION} installed"

echo "==> Updating lazydocker..."
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep tag_name | cut -d'"' -f4 | sed 's/v//')
curl -sLo /tmp/lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/download/v${LAZYDOCKER_VERSION}/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar -C /tmp -xzf /tmp/lazydocker.tar.gz lazydocker
sudo install /tmp/lazydocker /usr/local/bin
echo "    lazydocker ${LAZYDOCKER_VERSION} installed"

echo "==> Updating nvim..."
curl -sLo /tmp/nvim-linux-x86_64.tar.gz https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo tar -C /usr/local -xzf /tmp/nvim-linux-x86_64.tar.gz
sudo ln -sf /usr/local/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
echo "    nvim $(nvim --version | head -1) installed"
