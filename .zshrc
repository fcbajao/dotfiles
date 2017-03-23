export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "nojhan/liquidprompt"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

# END OF ZPLUG STUFF

eval "$(rbenv init -)"
export EDITOR=nvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
