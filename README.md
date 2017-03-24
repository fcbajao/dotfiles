# Dotfiles

My personal dotfiles.

## Prerequisites

Make zsh your default shell.
```
$ brew install zsh
# Then append /usr/local/bin/zsh to /etc/shells
$ chsh -s /usr/local/bin/zsh
```

Install zplug
```
$ brew install zplug
```

Install neovim with python3 support.
```
$ brew install python3
$ pip3 install neovim --upgrade
$ brew install neovim/neovim/neovim
```

Install the silver searcher
```
$ brew install the_silver_searcher
```

## Installation

Install the dotfiles with dotbot.
```
$ ./install
```

Then open a new terminal window and zplug will ask to install some plugins.

Also, run `:PlugInstall` on the first time you open neovim.

You might also want to install node using nvm that was installed from one of the zsh plugins.
```
$ nvm install v7
```
