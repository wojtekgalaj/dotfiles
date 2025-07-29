
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


# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/go/bin:$PATH"
export PATH=$GOPATH/bin:$PATH
export PATH=$HOME/go/bin/:$PATH
export PATH=$HOME/Library/Android/sdk/platform-tools:$PATH
export PATH=$HOME/tui/dev/scripts/bin/:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin/:$PATH

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




. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
. "/Users/wojtek/.deno/env"


# opencode
export PATH=/Users/wojtek/.opencode/bin:$PATH
