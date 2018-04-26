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

### Install zplug 

#### OSX

```
$ brew install zplug
```

#### Ubuntu

```
# Make sure you create /usr/local/opt and make it writable if it does not exist.
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
```

### Install neovim with python3 support.

#### OSX

```
$ brew install python3
$ pip3 install neovim --upgrade
$ brew install neovim/neovim/neovim
```

#### Ubuntu

```
# Ubuntu ships with Python 2 and 3
# So let's just instal pip
$ sudo apt-get install -y python3-pip
$ pip3 install neovim --upgrade
# Now we build from source (because I couldn't get apt-get install to work on 14.04)
# See https://github.com/neovim/neovim/wiki/Building-Neovim for steps
```

### Install the silver searcher

#### OSX

```
$ brew install the_silver_searcher
```

#### Ubuntu

```
$ sudo add-apt-repository ppa:pgolm/the-silver-searcher
$ sudo apt-get update
$ sudo apt-get install silversearcher-ag
```

### Install rbenv

#### OSX

```
$ brew install rbenv
```

#### Ubuntu

```
$ git clone https://github.com/rbenv/rbenv.git ~/.rbenv
$ echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zsh_custom
# exit and re-login then let's install ruby-build plugin
$ mkdir -p "$(rbenv root)"/plugins
$ git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
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

### Install Alacritty, Tmux, and Phoenix on OSX

This is only for my OSX setup but should also be doable in Ubuntu.
I use Alacritty as my terminal and then Phoenix to run my script
to toggle the terminal with a hotkey.

Install Alacritty https://github.com/jwilm/alacritty.

Then install Tmux and TPM.

```
$ brew install tmux
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Install tmux plugins.
```
$ tmux # Start session
# Then install plugins with Prefix + I
```

Then install Phoenix.

```
$ brew cask install phoenix
```
