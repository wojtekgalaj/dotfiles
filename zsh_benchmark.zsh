#!/usr/bin/env zsh
# zsh_benchmark.zsh - Compare startup times between different zsh configurations
# Usage: ./zsh_benchmark.zsh

# Create output file
OUTPUT_FILE="/tmp/zsh_benchmark_results.txt"
echo "ZSH Startup Benchmark Results" > $OUTPUT_FILE
echo "===========================" >> $OUTPUT_FILE
echo "Date: $(date)" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Function to measure zsh startup time
measure_startup() {
  local config=$1
  local desc=$2
  local cmd=$3
  local start=$(gdate +%s.%N 2>/dev/null || date +%s.%N)
  eval "$cmd"
  local end=$(gdate +%s.%N 2>/dev/null || date +%s.%N)
  local elapsed=$(echo "$end - $start" | bc)
  printf "%-20s: %6.3f seconds\n" "$desc" $elapsed >> $OUTPUT_FILE
  return $elapsed
}

# Test original configuration
echo "Testing original configuration..." | tee -a $OUTPUT_FILE
measure_startup "original" "Original zshrc" "ZDOTDIR=$HOME/.config/zsh zsh -i -c exit"

# Test minimal configuration
echo "Testing minimal configuration..." | tee -a $OUTPUT_FILE
cp ~/.config/zsh/.zshrc ~/.config/zsh/.zshrc.bak
cp ~/dotfiles/zsh/.config/zsh/minimal.zshrc ~/.config/zsh/.zshrc
measure_startup "minimal" "Minimal zshrc" "ZDOTDIR=$HOME/.config/zsh zsh -i -c exit"

# Test optimized configuration
echo "Testing optimized configuration..." | tee -a $OUTPUT_FILE
cp ~/dotfiles/zsh/.config/zsh/optimized.zshrc ~/.config/zsh/.zshrc
measure_startup "optimized" "Optimized zshrc" "ZDOTDIR=$HOME/.config/zsh zsh -i -c exit"

# Restore original configuration
cp ~/.config/zsh/.zshrc.bak ~/.config/zsh/.zshrc
rm ~/.config/zsh/.zshrc.bak

echo "" >> $OUTPUT_FILE
echo "Benchmark complete! Results saved to $OUTPUT_FILE"
cat $OUTPUT_FILE
