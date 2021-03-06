export EDITOR=vim

export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.local/npm-global/bin:$PATH
export PATH=$HOME/.emacs.d/bin:$PATH
export PATH=$HOME/Games/DwarfFortress:$PATH
export PATH=/usr/local/Cellar/emacs-plus@28/28.0.50/bin:$PATH


export ZDOTDIR=$HOME/.config/zsh

export NPM_PACKAGES=$HOME/.local/npm-global
export NPM_CONFIG_USERCONFIG=$HOME/.config/npmrc
export NODE_PATH=$NPM_PACKAGES/lib/node_modules:$NODE_PATH
export N_PREFIX=$HOME/.local
export PATH=$N_PREFIX/bin:$PATH

export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache

source $HOME/.nix-profile/etc/profile.d/nix.sh
