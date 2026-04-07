#zmodload zsh/zprof
fpath=(/Users/arnemunthe-kaas/.docker/completions $fpath)
autoload -Uz compinit
compinit

export PATH=/opt/homebrew/bin:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin # Set homebrew before system paths

function set_java_version() {
  export JAVA_HOME="$1"
  export PATH="$JAVA_HOME/bin:$PATH"
  java -version
}

export JAVA_21_HOME="$(/usr/libexec/java_home -v 21)"
export JAVA_17_HOME="$(/usr/libexec/java_home -v 17)"
export JAVA_11_HOME="$(/usr/libexec/java_home -v 11)"
export JAVA_8_HOME="$(/usr/libexec/java_home -v 1.8)"

alias java21='set_java_version "$JAVA_21_HOME"'
alias java17='set_java_version "$JAVA_17_HOME"'
alias java11='set_java_version "$JAVA_11_HOME"'
alias java8='set_java_version "$JAVA_8_HOME"'

# Set default to Java 21
export JAVA_HOME="$JAVA_21_HOME"
export PATH="$JAVA_HOME/bin:$PATH"

export HOMEBREW_AUTO_UPDATE_SECS=86400

alias python=python3
alias py=python
alias pip=pip3
alias k=kubectl
alias kx='kubectx'
alias ns='kubens'
alias kxns='kubectx; kubens'
alias ks='kubeshark tap; kubeshark clean'
export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"
alias httpybench='python3 /Users/arnemunthe-kaas/programming/side_projects/HttPyBench/httpybench.py'
alias chrome='open -a "Google Chrome"'
alias q='quarkus'

source "$HOME/.cargo/env"
alias c='cargo'
alias q='quarkus'
alias j='jerry'
alias jbm='jerry -r -e bmtest'
alias jdd='jerry -r -e ddbeta'
alias jp='jerry proxy -f'
alias ls='eza'
alias b='brew'
alias v='nvim'

alias g='git'
alias gc="git checkout"
alias gs="git stash"
alias gpl="git pull"
alias gpo="git push origin"
alias gb="git branch"
alias gfr="git fetch; git rebase;"
alias gfrm='git fetch origin && git rebase origin/$(git symbolic-ref --short refs/remotes/origin/HEAD | sed "s|^origin/||")'
alias gcm='git checkout $(git symbolic-ref --short refs/remotes/origin/HEAD | sed "s|^origin/||")'

alias helmfile0='/Users/arnemunthe-kaas/work/utils/helmfile_0.170.1/helmfile'

alias gda="/bin/bash /Users/arnemunthe-kaas/scripts/deletebranches.sh"

# Created by `pipx` on 2023-09-27 17:50:46
export PATH="$PATH:/Users/arnemunthe-kaas/.local/bin"

### Added by Zinit's installer
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

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light jonmosco/kube-ps1

# Define a function to check for a Git repo and count uncommitted files
git_prompt() {
    if [ -d .git ]; then
        local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
        local uncommitted=$(git status --short 2>/dev/null | wc -l)
        if [ -n "$branch" ]; then
            echo -n "%F{green}$branch"
            if [ $uncommitted -gt 0 ]; then
                echo -n " +%F{red}$uncommitted"
            fi
            echo -n "%f "
        fi
    fi
}

# Set the PS1 variable to customize your prompt
PROMPT='%F{yellow}%B%~%b%f ' # Current directory in bold yellow
PROMPT+='%F{cyan}$(git_prompt)' # Git branch and uncommitted files in cyan
PROMPT+='$(kube_ps1)' # Kubernetes context (toggle with kubeon/kubeoff)
PROMPT+=$'\n' # Newline before input
PROMPT+='%F{green}%#%f ' # '#' for root, '$' for regular user
kubeoff # Toggle with: kubeon / kubeoff
# Add conda environment to prompt
if [ ! -z "$CONDA_DEFAULT_ENV" ]
then
    PROMPT+="($CONDA_DEFAULT_ENV) "
fi

# Export maven home
export PATH=/opt/homebrew/opt/maven/bin:$PATH


eval "$(direnv hook zsh)"
eval "$(zoxide init --cmd cd zsh)"

movtogif() {
    input_file=$1
    output_file=$2

    if [[ -z "$input_file" || -z "$output_file" ]]; then
        echo "Usage: gif_convert <input_file> <output_file>"
        return 1
    fi

    ffmpeg -i "$input_file" -pix_fmt rgb8 -r 10 temp_output.gif && gifsicle -O3 temp_output.gif -o "$output_file"
    rm temp_output.gif
}

# Secrets loaded via ~/.zshenv -> ~/.secrets

source <(switcher init zsh)
alias s=switch
source <(switch completion zsh)
alias kubectx='switch'
alias kctx='switch'

alias firefox='open -a "Firefox"'

# Speed up nvm with 'zsh-nvm'
#export NVM_DIR="$HOME/.nvm"
#  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
#  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export NVM_LAZY_LOAD=true
source ~/.zsh-nvm/zsh-nvm.plugin.zsh

fastfetch

# Docker CLI completions (fpath added before compinit at top of file)


# Lazy-load pyenv — only initializes on first use of python/pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init --path)"
  eval "$(command pyenv init -)"
  pyenv "$@"
}