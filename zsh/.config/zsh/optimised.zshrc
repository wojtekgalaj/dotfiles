# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
[ ! -f "$HOME/.x-cmd.root/X" ] || . "$HOME/.x-cmd.root/X" # boot up x-cmd.

# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/wojtek/.config/zsh/completions:"* ]]; then export FPATH="/Users/wojtek/.config/zsh/completions:$FPATH"; fi

# This file was optimised by amazon q

# Enable colors and change prompt:
autoload -U colors && colors

# Basic auto/tab complete:
autoload -U compinit
# Only run compinit once a day
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.config/zsh/.zcompdump 2>/dev/null) ]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zmodload zsh/complist
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

# PATH additions - consolidated
path=(
  /usr/local/opt/ruby/bin
  /usr/local/go/bin
  $GOPATH/bin
  $HOME/go/bin
  $HOME/Library/Android/sdk/platform-tools
  $HOME/tui/dev/scripts/bin
  $HOME/.local/share/nvim/mason/bin
  $BUN_HOME
  $PNPM_HOME
  $path
)

export ANDROID_SDK=$HOME/Library/Android/sdk
export GOPATH=/$HOME/golib

# Lazy load starship
prompt_starship_precmd() {
  eval "$(starship init zsh --print-full-init)"
  # Clear this function after first run
  unfunction prompt_starship_precmd
}
precmd_functions+=(prompt_starship_precmd)

# Lazy load bun
bun() {
  unfunction bun
  export BUN_HOME="$HOME/.bun/bin/"
  export PATH="$BUN_HOME:$PATH"
  # bun completions
  [ -s "/Users/wojtek/.bun/_bun" ] && source "/Users/wojtek/.bun/_bun"
  bun "$@"
}

# Lazy load pnpm
pnpm() {
  unfunction pnpm
  export PNPM_HOME="/Users/wgalaj/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
  pnpm "$@"
}

# Source zprofile once
source ~/.zprofile

# Lazy load cargo
cargo() {
  unfunction cargo
  . "$HOME/.cargo/env"
  cargo "$@"
}

# Lazy load zoxide
z() {
  unfunction z
  eval "$(zoxide init zsh)"
  z "$@"
}

# Yazi file manager function
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Lazy load conda
conda() {
  unfunction conda
  # >>> conda initialize >>>
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
  conda "$@"
}

# Lazy load SDKMAN
sdk() {
  unfunction sdk
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  sdk "$@"
}

# Lazy load atuin
atuin() {
  unfunction atuin
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
  atuin "$@"
}

# Lazy load deno
deno() {
  unfunction deno
  . "/Users/wojtek/.deno/env"
  deno "$@"
}

# Lazy load fzf
fzf() {
  unfunction fzf
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  fzf "$@"
}

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
