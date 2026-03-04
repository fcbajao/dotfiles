# Dotfiles

Modern and minimal development environment setup for Linux & macOS — powered by **Zsh**, **Antidote**, and **mise**, with **Phoenix** for macOS or a local **GNOME extension** for Linux.

---

## What’s Inside

| Tool | Purpose |
| --- | --- |
| **Zsh** | Main shell |
| **Antidote** | Zsh plugin manager |
| **mise** | Runtime & tool version manager |
| **Neovim** | Main editor |
| **Alacritty** | GPU-accelerated terminal |
| **Alacritty Toggle** | Local GNOME extension (Linux) / Phoenix (macOS) |
| **tmux** | Terminal multiplexer |

---

## Prerequisites (Manual Setup Once)

Install the minimal base system tools before running any scripts:

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y zsh git curl gnome-shell-extension-prefs
chsh -s "$(which zsh)"

```

### Linux (Fedora/RHEL)

```bash
sudo dnf install -y zsh git curl
chsh -s "$(which zsh)"

```

### macOS

```bash
xcode-select --install
brew install zsh git curl
chsh -s "$(which zsh)"

```

---

## 🚀 Install & Bootstrap

```bash
# Clone this repository
git clone https://github.com/fcbajao/dotfiles ~/dotfiles
cd ~/dotfiles

# Install mise
curl https://mise.run | sh

# Run setup task for your OS
mise run bootstrap-fedora  # Fedora/RHEL
mise run bootstrap-ubuntu   # Ubuntu/Debian
mise run bootstrap-mac      # macOS

```

---

## Linux: Alacritty Keyboard Shortcut

For Linux with GNOME (Ubuntu/Fedora), we ship a local extension in this repo:

`~/.local/share/gnome-shell/extensions/alacritty-toggle@dotfiles.local`

The Linux bootstrap tasks automatically symlink, compile schemas, and configure:

- hotkey: **Ctrl + `**
- command: `$HOME/.cargo/bin/alacritty`
- app id: `Alacritty.desktop`

If GNOME does not pick up new extensions immediately, log out and back in once.

---

## macOS: Alacritty + Phoenix Shortcut

I use **Phoenix** as a lightweight window manager and hotkey launcher to toggle **Alacritty**.

### Install

```bash
brew install --cask phoenix alacritty

```

### Setup

The mise task `bootstrap-mac` will symlink the configuration:

```bash
ln -sf ~/dotfiles/.phoenix.js ~/.phoenix.js

```

Launch Phoenix and ensure "Open at Login" is checked. The script will automatically bind the toggle hotkey.
