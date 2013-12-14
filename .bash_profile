alias v=vim
alias s=sudo
alias bx="bundle exec"
alias bspec="bundle exec rspec"
alias bfcucumber="bundle exec cucumber -r features"
alias hupkill="sudo kill -HUP" # I use this for restarting nginx

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
