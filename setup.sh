#!/usr/bin/env bash

set -e

echo "Setting up config directories..."
mkdir -p ~/.config/nvim
mkdir -p ~/.config/alacritty
sudo mkdir -p /usr/local/opt
sudo chmod 777 /usr/local/opt

echo "Creating symbolic links of dotfiles..."
ln -srvf .zshrc ~/.zshrc
ln -srvf .gitconfig ~/.gitconfig
ln -srvf .gitignore_global ~/.gitignore_global
ln -srvf init.vim ~/.config/nvim/init.vim
ln -srvf alacritty.vim ~/.config/nvim/alacritty.vim
ln -srvf .phoenix.js ~/.phoenix.js
ln -srvf .tmux.conf ~/.tmux.conf

echo "Making sure apt-get is up to date..."
sudo apt-get update
sudo apt-get upgrade -y

echo "Installing neovim Plug!"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if [[ -d /usr/local/opt/zplug ]]; then
  echo "zplug already installed, skipping..."
else
  echo "Installing zplug!"
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi

if [[ -d ~/.asdf ]]; then
  echo "asdf already installed, skipping..."
else
  echo "Installing asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
fi
. ~/.asdf/asdf.sh

if asdf plugin list | grep -q nodejs; then
  echo "asdf nodejs plugin already installed, skipping..."
else
  echo "Installing asdf nodejs plugin"
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
fi
echo "Installing asdf nodejs latest"
asdf install nodejs latest
asdf global nodejs latest

if asdf plugin list | grep -q ruby; then
  echo "asdf ruby plugin already installed, skipping..."
else
  echo "Installing asdf ruby plugin"
  asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
fi
echo "Installing asdf ruby latest"
if ! [ -x "$(command -v apt-get)" ]; then
  echo "No apt-get found, assuming this is OSX."
  echo "Installing ruby dev dependencies...Make sure you also have installed Xcode Command Line Tools and Homebrew."
  brew install openssl readline
else
  echo "Command apt-get found, assuming this is Linux."
  echo "Installing ruby dev dependencies..."
  sudo apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm6 libgdbm-dev libdb-dev
fi
asdf install ruby latest
asdf global ruby latest

if asdf plugin list | grep -q golang; then
  echo "asdf golang plugin already installed, skipping..."
else
  echo "Installing asdf golang plugin"
  asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
fi
echo "Installing asdf golang latest"
asdf install golang latest
asdf global golang latest

if asdf plugin list | grep -q python; then
  echo "asdf python plugin already installed, skipping..."
else
  echo "Installing asdf python plugin"
  asdf plugin-add python https://github.com/danhper/asdf-python.git
fi
echo "Installing asdf python latest"
asdf install python latest
asdf global python latest

echo "Installing python neovim support"
pip3 install neovim --upgrade

if asdf plugin list | grep -q neovim; then
  echo "asdf neovim plugin already installed, skipping..."
else
  echo "Installing asdf neovim plugin"
  asdf plugin-add neovim https://github.com/richin13/asdf-neovim.git
fi
echo "Installing asdf neovim stable"
asdf install neovim stable
asdf global neovim stable

if asdf plugin list | grep -q tmux; then
  echo "asdf tmux plugin already installed, skipping..."
else
  echo "Installing asdf tmux plugin"
  asdf plugin-add tmux https://github.com/aphecetche/asdf-tmux.git
fi
echo "Installing asdf tmux latest"
if ! [ -x "$(command -v apt-get)" ]; then
  echo "No apt-get found, assuming this is OSX."
  echo "Installing tmux dependencies..."
  brew install unzip
else
  echo "Command apt-get found, assuming this is Linux."
  echo "Installing tmux dependencies..."
  sudo apt-get install -y unzip
fi
asdf install tmux latest
asdf global tmux latest

if [[ -d ~/.tmux/plugins/tpm ]]; then
  echo "tmux plugins already installed, skipping..."
else
  echo "Installing tmux plugins"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if ! [ -x "$(command -v apt-get)" ]; then
  echo "No apt-get found, assuming this is OSX."
  echo "Installing silver searcher..."
  brew install the_silver_searcher
else
  echo "Command apt-get found, assuming this is Linux."
  echo "Installing silver searcher..."
  sudo apt-get install -y silversearcher-ag
fi

if ! [ -x "$(command -v docker)" ]; then
  if ! [ -x "$(command -v apt-get)" ]; then
    echo "No apt-get found, assuming this is OSX."
    echo "Do manual install of Docker for Mac: https://docs.docker.com/desktop/mac/install/"
  else
    echo "Command apt-get found, assuming this is Linux."
    echo "Installing docker engine..."
    # Ref: https://docs.docker.com/engine/install/ubuntu/
    sudo apt-get install -y \
      ca-certificates \
      curl \
      gnupg \
      lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

    echo "Installing docker compose..."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
  fi
else
  echo "Command docker found, skipping install..."
fi

echo "Install neovim providers..."
gem install neovim
npm install -g neovim
npm install -g typescript

echo "Done."
