export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "akz92/clean", as:theme
zplug "lukechilds/zsh-nvm"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/bundler", from:oh-my-zsh
zplug "docker/docker", use:contrib/completion/zsh
zplug "docker/compose", use:contrib/completion/zsh

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

# END OF ZPLUG STUFF

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# For history substring search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# History sharing stuff
export SAVEHIST=2000
export HISTFILE=~/.zsh_history
setopt inc_append_history # append every command to history after execute
setopt share_history # share history between terminals

eval "$(rbenv init -)"
export EDITOR=nvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
