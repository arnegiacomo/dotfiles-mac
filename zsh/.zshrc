export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH="$PATH:$HOME/.local/bin"

export HOMEBREW_AUTO_UPDATE_SECS=86400

# Docker CLI completions
fpath=($HOME/.docker/completions $fpath)

alias python=python3
alias py=python3
alias pip=pip3

alias ls='eza --icons --color=always'
alias ll='eza --icons --color=always -la'
alias lt='eza --icons --color=always --tree --level=2'

alias v='nvim'
alias lg='lazygit'
alias ld='lazydocker'

alias gc="git checkout"
alias gs="git stash"
alias gpl="git pull"
alias gpo="git push origin"
alias gpu="git push -u origin HEAD"
alias gb="git branch"
alias gfr="git fetch; git rebase;"
alias gfrm='git fetch origin && git rebase origin/$(git symbolic-ref --short refs/remotes/origin/HEAD | sed "s|^origin/||")'
alias gcm='git checkout $(git symbolic-ref --short refs/remotes/origin/HEAD | sed "s|^origin/||")'

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS

### Zinit
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-completions
# Full compinit (security audit + freshness rebuild) at most once per 24h;
# fast -C path otherwise. Force a refresh with: rm -f ~/.zcompdump*; compinit
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-history-substring-search
zinit light Aloxaf/fzf-tab
zinit light MichaelAquilina/zsh-you-should-use

# Bind up/down arrows to history substring search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Direnv
eval "$(direnv hook zsh)"

# Node — lazy load via zsh-nvm
export NVM_LAZY_LOAD=true
[ -f ~/.zsh-nvm/zsh-nvm.plugin.zsh ] && source ~/.zsh-nvm/zsh-nvm.plugin.zsh

# Python — lazy-load pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init --path)"
  eval "$(command pyenv init -)"
  pyenv "$@"
}

# Starship prompt
eval "$(starship init zsh)"

# Zoxide (replaces cd) — must be after compinit
eval "$(zoxide init --cmd cd zsh)"

fastfetch
