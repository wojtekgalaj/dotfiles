#!/usr/bin/env zsh
# zsh_profiler.zsh - Profile zsh startup time
# Usage: zsh -i -c "source /Users/wojtek/dotfiles/zsh_profiler.zsh"

# Turn on tracing
zmodload zsh/zprof

# Start a new shell to load all configs
# This will automatically exit when done
zsh -i -c exit

# Display profiling results
zprof
