# ---------- mise ----------
eval "$(~/.local/bin/mise activate zsh)"

# ---------- Antidote (replaces zplug) ----------
if [[ -r "${HOME}/.antidote/antidote.zsh" ]]; then
  source "${HOME}/.antidote/antidote.zsh"
fi

ZSH_PLUGINS_FILE="$HOME/.config/zsh/zsh_plugins.txt"
ZSH_PLUGINS_COMPILED="$HOME/.config/zsh/zsh_plugins.zsh"

if [[ -r "$ZSH_PLUGINS_FILE" ]]; then
  if [[ ! -r "$ZSH_PLUGINS_COMPILED" || "$ZSH_PLUGINS_FILE" -nt "$ZSH_PLUGINS_COMPILED" ]]; then
    antidote bundle < "$ZSH_PLUGINS_FILE" > "$ZSH_PLUGINS_COMPILED"
  fi
  source "$ZSH_PLUGINS_COMPILED"
fi

autoload -Uz compinit && compinit -u

# ---------- Autosuggest styling ----------
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=240'

# ---------- History & keybindings (kept from your zshrc) ----------
bindkey '^[[A' history-substring-search-up    # Up arrow
bindkey '^[[B' history-substring-search-down  # Down arrow
bindkey '^P' history-substring-search-up      # Ctrl+P
bindkey '^N' history-substring-search-down    # Ctrl+N
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

export HISTSIZE=50000
export SAVEHIST=$HISTSIZE
export HISTFILE="$HOME/.zsh_history"
setopt inc_append_history       # append each command as it executes
setopt share_history            # share across terminals

# ---------- Locale ----------
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ---------- Editor / PATH additions ----------
export EDITOR="nvim"
export PATH="$HOME/.local/bin:$PATH"

# ---------- SSH keychain on macOS only ----------
if [[ "$OSTYPE" == darwin* ]]; then
  ssh-add -KA &>/dev/null
fi

# ---------- GitLab / aliases you had ----------
alias run_workhorse_tests="make clean test"
alias recompile_workhorse="make clean install && gdk restart gitlab-workhorse"
alias bspec="bundle exec rspec"

# ---------- Homebrew-specific env (guarded) ----------
if command -v brew >/dev/null 2>&1; then
  # ICU flag you kept
  export PKG_CONFIG_PATH="$(brew --prefix icu4c)/lib/pkgconfig:${PKG_CONFIG_PATH}"

  # Ruby build flags (modernize to OpenSSL 3)
  OPENSSL_PREFIX="$(brew --prefix openssl@3 2>/dev/null || true)"
  READLINE_PREFIX="$(brew --prefix readline 2>/dev/null || true)"
  if [[ -n "$OPENSSL_PREFIX" ]]; then
    export RUBY_CONFIGURE_OPTS="--disable-install-doc --with-openssl-dir=$OPENSSL_PREFIX${READLINE_PREFIX:+ --with-readline-dir=$READLINE_PREFIX}"
  fi
fi

# ---------- Per-machine overrides ----------
[[ -f ~/.zsh_custom ]] && source ~/.zsh_custom
