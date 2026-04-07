set fish_greeting ""

# PATH
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path /usr/local/go/bin

# Cargo/Rust
fish_add_path $HOME/.cargo/bin

# Bun
fish_add_path $HOME/.bun/bin

# Node — dynamically resolve latest nvm.fish-managed version so this doesn't break on upgrades
set -l _nvm_latest (ls -v $HOME/.local/share/nvm 2>/dev/null | grep '^v' | tail -1)
if test -n "$_nvm_latest"
    fish_add_path $HOME/.local/share/nvm/$_nvm_latest/bin
end

# Aliases — navigation (kept as alias, expansion would clutter the prompt)
alias ls 'eza --icons --color=always'
alias ll 'eza --icons --color=always -la'
alias lt 'eza --icons --color=always --tree --level=2'

# Aliases — python
alias python 'python3'
alias py 'python3'
alias pip 'pip3'

# Abbreviations — editors & tools (expands inline so you see what runs)
abbr --add v nvim
abbr --add lg lazygit
abbr --add ld lazydocker
abbr --add c cargo

# Abbreviations — git
abbr --add g git
abbr --add gc 'git checkout'
abbr --add gs 'git stash'
abbr --add gpl 'git pull'
abbr --add gpo 'git push origin'
abbr --add gb 'git branch'
abbr --add gfr 'git fetch; and git rebase'
abbr --add gfrm 'git fetch origin; and git rebase origin/(git symbolic-ref --short refs/remotes/origin/HEAD | string replace "origin/" "")'
abbr --add gcm 'git checkout (git symbolic-ref --short refs/remotes/origin/HEAD | string replace "origin/" "")'

# Direnv
direnv hook fish | source

# Zoxide (replaces cd)
zoxide init --cmd cd fish | source

# Starship prompt
starship init fish | source

# Fastfetch on new terminal
if status is-interactive
    fastfetch
end
