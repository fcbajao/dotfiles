# Dotfiles

Modern and minimal development environment setup for Linux & macOS — powered by **Zsh**, **Antidote**, and **mise**, with optional **Phoenix** for macOS shortcuts.

---

## What’s Inside

| Tool                | Purpose                           |
| ------------------- | --------------------------------- |
| **Zsh**             | Main shell                        |
| **Antidote**        | Zsh plugin manager                |
| **mise**            | Runtime & tool version manager    |
| **Neovim**          | Main editor                       |
| **Node (npm)**      | JavaScript/TypeScript runtime     |
| **Ruby**            | For Rails and scripting           |
| **tmux**            | Terminal multiplexer              |
| **Phoenix (macOS)** | Window manager & Alacritty hotkey |

---

## Prerequisites (Manual Setup Once)

Install the minimal base system tools before running any scripts:

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y zsh git curl
chsh -s "$(which zsh)"
```

### macOS

```bash
xcode-select --install
brew install zsh git curl
chsh -s "$(which zsh)"
```

Then restart your terminal or run `exec zsh` to start using Zsh.

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

## macOS: Alacritty + Phoenix Shortcut

I use **Phoenix** as a lightweight window manager and hotkey launcher to toggle **Alacritty**.

### Install (manual — not managed by mise)

Phoenix is a GUI app and cannot be installed via mise. Use Homebrew cask instead:

```bash
brew install --cask phoenix
```

Then download and install Alacritty app from https://alacritty.org/.

### Setup

The mise task `bootstrap-mac` will do the following:

```bash
ln -sf ~/dotfiles/.phoenix.js ~/.phoenix.js
```

Then launch Phoenix (`open -a Phoenix`). The `.phoenix.js` script defines a hotkey to summon or focus Alacritty instantly.

> Phoenix automatically reloads configs when `.phoenix.js` changes — or use the menu bar → **Reload Config**.


## Ubuntu: Alacritty Keyboard Shortcut

The mise task `bootstrap-ubuntu` will symlink `toggle_alacritty` to the `~/.local/bin` thus we can add this command directly to the keyboard shortcuts settings section.
