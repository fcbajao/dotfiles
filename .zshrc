export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "akz92/clean", as:theme
zplug "lukechilds/zsh-nvm"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "rupa/z", use:z.sh

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
export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
export HISTFILE=~/.zsh_history
setopt inc_append_history # append every command to history after execute
setopt share_history # share history between terminals

export EDITOR=nvim
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.zsh_custom ] && source ~/.zsh_custom # Allow custom stuff that you have per machine.

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Since OSX Sierra doesn't save SSH keys into the keychain anymore
# Ref: https://blog.elao.com/en/tech/ssh-agent-does-not-automatically-load-passphrases-on-the-osx-sierra-keychain/
ssh-add -KA &> /dev/null

alias run_workhorse_tests="grc make clean test"

. $HOME/.asdf/asdf.sh

# Added by GDK bootstrap
export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig:${PKG_CONFIG_PATH}"

# Added by GDK bootstrap
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1 --with-readline-dir=/usr/local/opt/readline"
