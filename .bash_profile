alias v=vim
alias s=sudo
alias hupkill="sudo kill -HUP" # I use this for restarting nginx
alias bx="bundle exec"
alias bxc="bundle _1.0.21_ exec"
alias bspec="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bundle exec rspec"
alias bcucumber="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bundle exec cucumber"
alias bfcucumber="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bundle exec cucumber -r features"
alias ballspec="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bundle exec rake spec"
alias ballcucumber="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bundle exec rake cucumber"
alias balltests="RUBY_GC_MALLOC_LIMIT=90000000 RUBY_FREE_MIN=200000 bundle exec rake spec cucumber"
alias simulator='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
alias ssh_to_staging='ey ssh -e carabao_staging_postgres92'
alias ssh_to_production='ey ssh -e carabao_production_postgres92'
alias ssh_to_staging_db='ssh deploy@ec2-54-251-16-212.ap-southeast-1.compute.amazonaws.com'
alias ssh_to_prod_db='ssh deploy@ec2-54-251-87-85.ap-southeast-1.compute.amazonaws.com'

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
