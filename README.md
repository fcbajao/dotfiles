# Dotfiles

My personal dotfiles.

## Prerequisites

### Make zsh your default shell.

#### OSX

```
$ brew install zsh
# Then append /usr/local/bin/zsh to /etc/shells
$ chsh -s /usr/local/bin/zsh
```
#### Ubuntu

```
$ sudo apt-get update
$ sudo apt-get upgrade
$ sudo apt-get install zsh
$ chsh -s /bin/zsh
# Exit and re-login
```

## Installation

Install the dotfiles with dotbot.
```
$ ./setup.sh
```

Then open a new terminal window and zplug will ask to install some plugins.

Also, run `:PlugInstall` on the first time you open neovim.

### Install Alacritty and Phoenix on OSX

This is only for my OSX setup but should also be doable in Ubuntu.
I use Alacritty as my terminal and then Phoenix to run my script
to toggle the terminal with a hotkey.

Install Alacritty https://github.com/jwilm/alacritty.

Then install Phoenix.

```
$ brew cask install phoenix
```

### Troubleshooting

When you get the following error:
```
_complete:96: bad math expression: operand expected at end of string
```

Run the following:
```
$ compaudit | xargs chmod g-w
```

Ref: https://stackoverflow.com/a/66466076
