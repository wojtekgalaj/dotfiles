# Minimal zshrc for testing startup time
# To use: ZDOTDIR=$HOME/.config/zsh zsh -c "export ZDOTDIR=$HOME/.config/zsh; exec zsh -i"

# Basic settings
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Basic key bindings (emacs mode)
bindkey -e

# Basic prompt
PS1="%n@%m %~ %# "

# Basic completion
autoload -Uz compinit
compinit -C

# End of minimal config
# Uncomment sections below to gradually add functionality

# Vi mode
# bindkey -v
# export KEYTIMEOUT=1

# Basic aliases
# alias ls='ls -G'
# alias ll='ls -la'

# PATH additions
# export PATH=$HOME/.local/bin:$PATH

# External tools
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Uncomment to measure startup time
# time (zsh -i -c exit)

echo "Minimal zshrc loaded successfully!"
