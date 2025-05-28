# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Command aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# This line sets the dmenu bar's appearance to its default look
alias dmenu="dmenu -m \"0\" -fn \"monospace:size=18\" -nb \"#222222\" -nf \"#bbbbbb\" -sb \"#005577\" -sf \"#eeeeee\""

alias mv='mv -vi'
alias cp='cp -vi'
alias rm='rm -vI'
alias mkdir='mkdir -vp'
alias ln='ln -v'
alias xclip='xclip -r -sel clip'
alias feh='feh --fullscreen -S name --version-sort'
alias lf='lfub'
alias pacs='sudo pacman -Sy --needed'
alias pacr='sudo pacman -Rnus'
alias yays='yay -S --answerclean All --answerdiff None'
alias yayr='yay -Rnus'
alias lobster='lobster -i'
alias zathura='zathura -l warning'
alias wget --hsts-file="$XDG_CACHE_HOME"/wget-hsts

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# Use neovim to edit protected files with sudoedit
export SUDO_EDITOR="nvim"
alias "sudoedit"='function _sudoedit() { sudo -e "$1"; } ; _sudoedit'

# History in state directory:
HISTSIZE=10000
SAVEHIST=10000
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
HISTFILE="$XDG_STATE_HOME"/zsh/history

# Run an ssh-agent process, if there is not one already. #
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [ ! -f "$SSH_AUTH_SOCK" ]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

# Keybinds #

# Make Ctrl+Left and Ctrl+Right behave like Bash
autoload -U select-word-style
select-word-style bash

bindkey '^[[1;5C' forward-word    # Ctrl + Right
bindkey '^[[1;5D' backward-word   # Ctrl + Left

# Prevent Ctrl + D from exiting zsh
setopt IGNORE_EOF
bindkey '^D' delete-char          # Ctrl + D

bindkey '^[[H' beginning-of-line  # Home
bindkey '^[[4~' end-of-line       # End

# Enable carriage return at prompt (Gets rid of `%`)
setopt PROMPT_CR
setopt PROMPT_SP
export PROMPT_EOL_MARK=""

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

: <<'EOF'
# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.
EOF

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
#autoload edit-command-line; zle -N edit-command-line
#bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
ZSH_HIGHLIGHT_STYLES[globbing]='fg=yellow,bold'

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null

