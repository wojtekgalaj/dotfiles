# deferred.zsh - Load heavy components on demand
# Source this file when you need these tools: source ~/.config/zsh/deferred.zsh

# Load conda
if [ -z "$CONDA_LOADED" ]; then
  echo "Loading conda..."
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
  export CONDA_LOADED=1
fi

# Load SDKMAN
if [ -z "$SDKMAN_LOADED" ]; then
  echo "Loading SDKMAN..."
  export SDKMAN_DIR="$HOME/.sdkman"
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
  export SDKMAN_LOADED=1
fi

# Load atuin
if [ -z "$ATUIN_LOADED" ]; then
  echo "Loading atuin..."
  . "$HOME/.atuin/bin/env"
  eval "$(atuin init zsh)"
  export ATUIN_LOADED=1
fi

# Load deno
if [ -z "$DENO_LOADED" ]; then
  echo "Loading deno..."
  . "/Users/wojtek/.deno/env"
  export DENO_LOADED=1
fi

# Load bun
if [ -z "$BUN_LOADED" ]; then
  echo "Loading bun..."
  export BUN_HOME="$HOME/.bun/bin/"
  export PATH="$BUN_HOME:$PATH"
  # bun completions
  [ -s "/Users/wojtek/.bun/_bun" ] && source "/Users/wojtek/.bun/_bun"
  export BUN_LOADED=1
fi

# Load pnpm
if [ -z "$PNPM_LOADED" ]; then
  echo "Loading pnpm..."
  export PNPM_HOME="/Users/wgalaj/.local/share/pnpm"
  export PATH="$PNPM_HOME:$PATH"
  export PNPM_LOADED=1
fi

# Load cargo
if [ -z "$CARGO_LOADED" ]; then
  echo "Loading cargo..."
  . "$HOME/.cargo/env"
  export CARGO_LOADED=1
fi

echo "All deferred components loaded!"
