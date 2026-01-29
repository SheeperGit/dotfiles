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

export XINITRC="$XDG_CONFIG_HOME"/x11/xinitrc
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority # May break some DMs.
export XCURSOR_PATH=/usr/share/icons:$XDG_DATA_HOME/icons
export XCURSOR_THEME=breeze_cursors
export QT_QPA_PLATFORMTHEME=qt5ct

export ZDOTDIR="$XDG_CONFIG_HOME"/zsh
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYTHON_HISTORY=$XDG_STATE_HOME/python_history
export WINEPREFIX="$XDG_DATA_HOME"/wine
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export BN_USER_DIRECTORY="$XDG_CONFIG_HOME"/binaryninja

# Command aliases

# Private environment variables. Usually used for scripts.
if [ -d "$PATH_DIR/.private" ]; then
  for f in "$PATH_DIR/.private"/*; do
    [ -f "$f" ] && source "$f"
  done
fi

# Start graphical server on user's current tty if not already running.
[ "$(tty)" = "/dev/tty1" ] && ! pidof -s Xorg >/dev/null 2>&1 && exec startx "$XINITRC"

