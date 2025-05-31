# ZSH Startup Optimization

This document explains how to use the tools in this repository to optimize your zsh startup time.

## Files Included

1. **zsh_detailed_profiler.zsh**: Profiles your current zsh configuration to identify slow components
2. **zsh_benchmark.zsh**: Compares startup times between different zsh configurations
3. **zsh/.config/zsh/minimal.zshrc**: A minimal zshrc for testing
4. **zsh/.config/zsh/optimized.zshrc**: An optimized version of your current zshrc
5. **zsh/.config/zsh/deferred.zsh**: A file containing heavy components that can be loaded on demand
6. **cleanup.md**: General tips for optimizing zsh startup time

## How to Use These Files

### 1. Profile Your Current Configuration

```bash
# Make the profiler executable
chmod +x ~/dotfiles/zsh_detailed_profiler.zsh

# Run the profiler
~/dotfiles/zsh_detailed_profiler.zsh
```

This will show you which components of your zsh configuration are taking the most time to load.

### 2. Benchmark Different Configurations

```bash
# Make the benchmark script executable
chmod +x ~/dotfiles/zsh_benchmark.zsh

# Run the benchmark
~/dotfiles/zsh_benchmark.zsh
```

This will compare the startup times of your original configuration, the minimal configuration, and the optimized configuration.

### 3. Try the Minimal Configuration

```bash
# Backup your current zshrc
cp ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.bak

# Use stow to install the minimal configuration
cd ~/dotfiles
stow --dotfiles zsh

# Test it
zsh -i -c exit
```

### 4. Try the Optimized Configuration

```bash
# Replace minimal.zshrc with optimized.zshrc
cp ~/dotfiles/zsh/.config/zsh/optimized.zshrc ~/dotfiles/zsh/.config/zsh/.zshrc

# Use stow to install the optimized configuration
cd ~/dotfiles
stow --dotfiles zsh

# Test it
zsh -i -c exit
```

### 5. Use Deferred Loading

The `deferred.zsh` file contains heavy components that can be loaded on demand. To use it:

```bash
# In your interactive shell, when you need these components
source ~/.config/zsh/deferred.zsh
```

## Key Optimizations in the Optimized Configuration

1. **Lazy Loading**: Heavy components like conda, SDKMAN, atuin, etc. are only loaded when you actually use them
2. **Optimized Completion**: compinit is only run once a day
3. **Consolidated PATH**: All PATH additions are consolidated into a single declaration
4. **Deferred Loading**: Heavy components can be loaded on demand

## Reverting to Your Original Configuration

```bash
# Restore your original zshrc
cp ~/.config/zsh/.zshrc.bak ~/.config/zsh/.zshrc
```

## Further Customization

Feel free to modify the optimized.zshrc to better suit your needs. The key is to:

1. Lazy load components you don't use in every session
2. Consolidate PATH additions
3. Defer loading of heavy components
4. Only run compinit once a day
