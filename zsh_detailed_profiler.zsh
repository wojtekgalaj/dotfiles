#!/usr/bin/env zsh
# zsh_detailed_profiler.zsh - Detailed profiling of zsh startup
# Usage: zsh -i -c "source ~/dotfiles/zsh_detailed_profiler.zsh"

# Function to measure execution time of a command
measure() {
  local cmd=$1
  local desc=$2
  local start=$(gdate +%s.%N 2>/dev/null || date +%s.%N)
  eval "$cmd"
  local end=$(gdate +%s.%N 2>/dev/null || date +%s.%N)
  local elapsed=$(echo "$end - $start" | bc)
  printf "%-40s: %6.3f seconds\n" "$desc" $elapsed
}

# Create a temporary zshrc file
TMP_ZSHRC=$(mktemp)
TMP_ZPROFILE=$(mktemp)

# Extract sections from your zshrc
grep -n "# >>>" ~/.config/zsh/.zshrc | while read line; do
  section_start=$(echo $line | cut -d: -f1)
  section_name=$(echo $line | cut -d: -f2- | sed 's/# >>> //')
  next_section=$(grep -n "# >>>" ~/.config/zsh/.zshrc | awk -v start=$section_start '$1 > start {print $1; exit}' | cut -d: -f1)
  if [ -z "$next_section" ]; then
    next_section=$(wc -l < ~/.config/zsh/.zshrc)
  fi
  echo "# >>> $section_name" > $TMP_ZSHRC
  sed -n "${section_start},${next_section}p" ~/.config/zsh/.zshrc >> $TMP_ZSHRC
  measure "source $TMP_ZSHRC" "$section_name"
done

# If no sections found, measure common components
if [ ! -s "$TMP_ZSHRC" ]; then
  echo "No sections found, measuring common components..."
  
  # Measure compinit
  echo "autoload -U compinit && compinit" > $TMP_ZSHRC
  measure "source $TMP_ZSHRC" "compinit initialization"
  
  # Measure starship if present
  if grep -q "starship init" ~/.config/zsh/.zshrc; then
    echo 'eval "$(starship init zsh)"' > $TMP_ZSHRC
    measure "source $TMP_ZSHRC" "starship initialization"
  fi
  
  # Measure conda if present
  if grep -q "conda initialize" ~/.config/zsh/.zshrc; then
    grep -A 20 "# >>> conda initialize >>>" ~/.config/zsh/.zshrc | grep -B 20 "# <<< conda initialize <<<" > $TMP_ZSHRC
    measure "source $TMP_ZSHRC" "conda initialization"
  fi
  
  # Measure SDKMAN if present
  if grep -q "SDKMAN" ~/.config/zsh/.zshrc; then
    grep -A 2 "SDKMAN_DIR" ~/.config/zsh/.zshrc > $TMP_ZSHRC
    measure "source $TMP_ZSHRC" "SDKMAN initialization"
  fi
  
  # Measure atuin if present
  if grep -q "atuin init" ~/.config/zsh/.zshrc; then
    grep -A 2 "atuin" ~/.config/zsh/.zshrc > $TMP_ZSHRC
    measure "source $TMP_ZSHRC" "atuin initialization"
  fi
  
  # Measure zoxide if present
  if grep -q "zoxide init" ~/.config/zsh/.zshrc; then
    echo 'eval "$(zoxide init zsh)"' > $TMP_ZSHRC
    measure "source $TMP_ZSHRC" "zoxide initialization"
  fi
  
  # Measure fzf if present
  if grep -q "fzf.zsh" ~/.config/zsh/.zshrc; then
    echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' > $TMP_ZSHRC
    measure "source $TMP_ZSHRC" "fzf initialization"
  fi
  
  # Measure PATH additions
  grep "export PATH" ~/.config/zsh/.zshrc > $TMP_ZSHRC
  measure "source $TMP_ZSHRC" "PATH additions in zshrc"
  
  grep "export PATH" ~/.config/zsh/.zprofile > $TMP_ZPROFILE
  measure "source $TMP_ZPROFILE" "PATH additions in zprofile"
fi

# Measure total startup time
measure "zsh -i -c exit" "Total zsh startup time"

# Clean up
rm $TMP_ZSHRC $TMP_ZPROFILE

echo "\nResults are sorted by execution time (slowest first):"
echo "----------------------------------------------------"
# Sort results by time (assuming they're in the format produced above)
cat /tmp/zsh_profile_results.txt 2>/dev/null | sort -k 2 -n -r

echo "\nRecommendations:"
echo "---------------"
echo "1. Consider lazy-loading slow components (>0.1s)"
echo "2. Check for redundant PATH additions"
echo "3. Use async loading for plugins when possible"
echo "4. See ~/dotfiles/cleanup.md for detailed optimization tips"
