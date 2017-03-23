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

## Installation

Install the dotfiles with dotbot.
```
$ ./install
```
