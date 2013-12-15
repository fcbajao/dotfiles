alias v=vim
alias s=sudo
alias bx="bundle exec"
alias bspec="bundle exec rspec"
alias bfcucumber="bundle exec cucumber -r features"
alias hupkill="sudo kill -HUP" # I use this for restarting nginx

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# Git completion stuff
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

[[ -s "$HOME/.bashrc" ]] && source "$HOME/.bashrc" # Load the default .bashrc
[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
