This updated **README.md** reflects your new setup using the GNOME extension, ensuring a robust "Quake-mode" experience that works on both Wayland and X11.

---

# Dotfiles

Modern and minimal development environment setup for Linux & macOS — powered by **Zsh**, **Antidote**, and **mise**, with optional **Phoenix** for macOS or **GNOME Extensions** for Ubuntu shortcuts.

---

## What’s Inside

| Tool | Purpose |
| --- | --- |
| **Zsh** | Main shell |
| **Antidote** | Zsh plugin manager |
| **mise** | Runtime & tool version manager |
| **Neovim** | Main editor |
| **Alacritty** | GPU-accelerated terminal |
| **Alacritty Toggle** | GNOME Extension (Linux) / Phoenix (macOS) |
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

# Run setup task
mise run bootstrap-(ubuntu|mac)

```

---

## Ubuntu: Alacritty Keyboard Shortcut

For Ubuntu (Wayland or X11), we use the [GNOME Alacritty Toggle](https://github.com/axxapy/gnome-alacritty-toggle) extension. This provides a high-performance toggle that handles window focus and minimization natively.

### 1. Install the Extension

```bash
git clone https://github.com/axxapy/gnome-alacritty-toggle.git \
  ~/.local/share/gnome-shell/extensions/toggle-alacritty@itstime.tech

```

### 2. Enable & Configure

After installing, log out and back in (or restart GNOME). Then, enable the extension and apply our custom settings for the **Ctrl + `** hotkey and the **Cargo** binary path:

```bash
# Define the schema directory for the commands below
export ALAC_SCHEMA="--schemadir ~/.local/share/gnome-shell/extensions/toggle-alacritty@itstime.tech/schemas"

# Set hotkey to Ctrl + ` (grave)
gsettings $ALAC_SCHEMA set org.gnome.shell.extensions.toggle-alacritty toggle-key "['<Control>grave']"

# Point to the Alacritty binary installed via Cargo
gsettings $ALAC_SCHEMA set org.gnome.shell.extensions.toggle-alacritty command "$HOME/.cargo/bin/alacritty"

# Optional: Don't hide the terminal when entering GNOME Overview
gsettings $ALAC_SCHEMA set org.gnome.shell.extensions.toggle-alacritty hide-on-overview false

```

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
