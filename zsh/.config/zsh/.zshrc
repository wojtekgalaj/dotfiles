# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/wojtek/.config/zsh/completions:"* ]]; then export FPATH="/Users/wojtek/.config/zsh/completions:$FPATH"; fi
# Copied from Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# bind option+backspace to delete last word back without leaving insert mode  
bindkey '^H' backward-kill-word

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

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

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/go/bin/:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=$HOME/dev/scripts/bin/:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin/:$PATH

export ANDROID_SDK=$HOME/Library/Android/sdk
export GOPATH=/$HOME/golib

eval "$(starship init zsh)"

# bun
export BUN_HOME="$HOME/.bun/bin/"
export PATH="$BUN_HOME:$PATH"
# bun end

# pnpm
export PNPM_HOME="/Users/wgalaj/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
#
source ~/.zprofile

# Source cargo env
. "$HOME/.cargo/env"

eval "$(zoxide init zsh)"

# bun completions
[ -s "/Users/wojtek/.bun/_bun" ] && source "/Users/wojtek/.bun/_bun"


# This function is copied from the yazi documentation. It makes it so that
# leaving yazi by pressign 'q' will change the cwd to the folder you were in.
# To envoke the function just type 'y'.
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wojtek/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wojtek/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/wojtek/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wojtek/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
. "/Users/wojtek/.deno/env"
