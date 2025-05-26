#!/bin/sh
# shellcheck disable=SC2155

# PATH exports
# Add all directories in `~/.local/bin` to $PATH
PATH_DIR="$HOME/.local/bin" # "Master" PATH directory.
export PATH="$PATH:$(find "$PATH_DIR" -type d -path "$PATH_DIR/.*" -prune -o -type d -print | paste -sd ':' -)"

# Profile file, runs on login. Environmental variables are set here.

unsetopt PROMPT_SP 2>/dev/null

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export TERMINAL_PROG="st"
export BROWSER="firefox"

# ~/ Clean-up:
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state
export XDG_CACHE_HOME=$HOME/.cache

export QT_QPA_PLATFORMTHEME="gtk2"        # Have QT use gtk2 theme.
export XINITRC="/etc/X11/xinit/xinitrc"

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
export HISTFILE="${XDG_STATE_HOME}"/zsh/history
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export WINEPREFIX="$XDG_DATA_HOME"/wine
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export WGETRC="$XDG_CONFIG_HOME/wgetrc"

# Command aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"

# Private environment variables. Usually used for scripts.
[ -f "$PATH_DIR/.private/location" ] && source "$PATH_DIR/.private/location"

# Start graphical server on user's current tty if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

