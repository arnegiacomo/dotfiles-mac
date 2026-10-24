eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Homebrew's rustup is keg-only: its bin holds the cargo/rustc proxies, ~/.cargo/bin holds `cargo install` binaries
export PATH="$HOMEBREW_PREFIX/opt/rustup/bin:$HOME/.cargo/bin:$PATH"

# Created by `pipx` on 2023-09-27 17:50:46
export PATH="$PATH:$HOME/.local/bin"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
