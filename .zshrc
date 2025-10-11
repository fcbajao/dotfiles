#!/bin/zsh

# Create a temporary copy of zshrc
cp ~/.zshrc ~/.zshrc.tmp

# Add profiling code at the beginning
echo '
zmodload zsh/datetime
setopt PROMPT_SUBST
PS4='+$EPOCHREALTIME %N:%i> '
logfile=$(mktemp zsh_profile.XXXXXXXX)
exec 3>&2 2>$logfile
setopt XTRACE
' | cat - ~/.zshrc.tmp > ~/.zshrc.profile

# Start a new shell to collect profiling data
ZDOTDIR=~ zsh -i -c exit

# Process the log file
echo "\nStartup time breakdown:"
echo "----------------------"
grep -v "prompt_status" $logfile | grep -v "prompt_dir" | \
awk '{
    if (NR > 1) {
        duration = $1 - last_time
        printf "%.4fs - %s\n", duration, substr($0, index($0,$3))
    }
    last_time = $1
}' | sort -nr | head -n 20

# Calculate total time
total_time=$(awk 'NR==1{first=$1} END{printf "%.4f", $1-first}' $logfile)
echo "\nTotal startup time: ${total_time}s"

# Cleanup
rm $logfile
mv ~/.zshrc.tmp ~/.zshrc

echo "\nSuggested improvements:"
echo "---------------------"
# Check for specific slow components
grep "nvm" ~/.zshrc >/dev/null && echo "- Consider using 'defer:1' for nvm plugin"
grep "conda initialize" ~/.zshrc >/dev/null && echo "- Consider removing or deferring conda initialization"
grep "rbenv init" ~/.zshrc >/dev/null && echo "- Consider lazy loading rbenv"
grep "pyenv init" ~/.zshrc >/dev/null && echo "- Consider lazy loading pyenv"
grep "nodenv init" ~/.zshrc >/dev/null && echo "- Consider lazy loading nodenv"
