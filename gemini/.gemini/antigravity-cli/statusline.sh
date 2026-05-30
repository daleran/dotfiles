#!/bin/bash
# statusline.sh - Custom TUI status line script for Antigravity CLI with hyper-minimalist responsive scaling

# Read the JSON payload from stdin
input=$(cat)

# Query current terminal columns (Antigravity sets COLUMNS env, fallback to tput /dev/tty)
cols=${COLUMNS:-$(tput cols < /dev/tty 2>/dev/null || echo 120)}
# Fallback to default if cols is not a valid number
if ! [[ "$cols" =~ ^[0-9]+$ ]]; then
  cols=120
fi

# Extract fields with safe fallbacks
model=$(echo "$input" | jq -r '.model.display_name // .model.id // "Unknown Model"')
[ "$model" = "null" ] && model="Unknown Model"

effort=$(echo "$input" | jq -r '.effort | if type == "object" then .level else . end // "auto"' 2>/dev/null || echo "auto")
[ "$effort" = "null" ] && effort="auto"

# Round the used percentage to the nearest integer using jq's round
context_int=$(echo "$input" | jq -r '(.context_window.used_percentage // 0) | round')

# Extract token metrics
in_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // .context_window.current_usage.input_tokens // 0')
[ "$in_tokens" = "null" ] && in_tokens=0
out_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // .context_window.current_usage.output_tokens // 0')
[ "$out_tokens" = "null" ] && out_tokens=0
total_tokens=$((in_tokens + out_tokens))

# Extract duration metric (total session duration in milliseconds)
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // .cost.duration_ms // .duration_ms // 0')
[ "$duration_ms" = "null" ] && duration_ms=0

# Define ANSI color escape codes (compatible with Alacritty's ayu-dark theme)
RESET="\033[0m"
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"
GREEN="\033[1;32m"

# Style the effort level dynamically
case "${effort,,}" in
  high|xhigh|max)
    EFFORT_COLOR="\033[1;31m" # Bold Red
    ;;
  medium)
    EFFORT_COLOR="\033[1;33m" # Bold Yellow
    ;;
  *)
    EFFORT_COLOR="\033[1;32m" # Bold Green
    ;;
esac

# Style the context window usage dynamically based on memory thresholds
if [ "$context_int" -ge 80 ]; then
  CONTEXT_COLOR="\033[1;31m" # Bold Red (Dangerous usage)
elif [ "$context_int" -ge 50 ]; then
  CONTEXT_COLOR="\033[1;33m" # Bold Yellow (Warning usage)
else
  CONTEXT_COLOR="\033[1;32m" # Bold Green (Safe usage)
fi

# Formatting helper functions
format_number() {
  local num=$1
  if [ -z "$num" ] || [ "$num" -le 0 ] || [ "$num" = "null" ]; then
    echo "0"
  elif [ "$num" -ge 1000000 ]; then
    awk -v n="$num" 'BEGIN {printf "%.1fM", n/1000000}'
  elif [ "$num" -ge 1000 ]; then
    awk -v n="$num" 'BEGIN {printf "%.1fk", n/1000}'
  else
    echo "$num"
  fi
}

format_duration() {
  local ms=$1
  if [ -z "$ms" ] || [ "$ms" -le 0 ] || [ "$ms" = "null" ]; then
    echo "0s"
    return
  fi
  local seconds=$((ms / 1000))
  local minutes=$((seconds / 60))
  local hours=$((minutes / 60))
  
  local s=$((seconds % 60))
  local m=$((minutes % 60))
  local h=$((hours))
  
  if [ $h -gt 0 ]; then
    printf "%dh %dm %ds" $h $m $s
  elif [ $m -gt 0 ]; then
    printf "%dm %ds" $m $s
  else
    printf "%ds" $s
  fi
}

# Responsive design formatting based on current terminal columns
if [ "$cols" -ge 110 ]; then
  # Wide mode: Detailed token split but no labels
  formatted_tokens="$(format_number $total_tokens) ($(format_number $in_tokens) In/$(format_number $out_tokens) Out)"
  formatted_duration="$(format_duration $duration_ms)"
  
  # Extract subagents info dynamically
  subagents_count=$(echo "$input" | jq '.subagents | length // 0')
  if [ -n "$subagents_count" ] && [ "$subagents_count" -gt 0 ] && [ "$subagents_count" != "null" ]; then
    running_count=$(echo "$input" | jq '[.subagents[] | select(.status == "running" or .status == "working")] | length')
    waiting_count=$(echo "$input" | jq '[.subagents[] | select(.status == "waiting" or .status == "idle")] | length')
    
    if [ "$running_count" -gt 0 ] && [ "$waiting_count" -gt 0 ]; then
      sub_detail=" (${running_count}R/${waiting_count}W)"
    elif [ "$running_count" -gt 0 ]; then
      sub_detail=" (${running_count}R)"
    elif [ "$waiting_count" -gt 0 ]; then
      sub_detail=" (${waiting_count}W)"
    else
      sub_detail=""
    fi
    SUBAGENT_COLOR="\033[1;34m"
    subagents_part="  ${SUBAGENT_COLOR} ${subagents_count}${sub_detail}${RESET}"
  else
    subagents_part=""
  fi

  echo -e "${CYAN}󰚩 ${model}${RESET}  ${EFFORT_COLOR}⚡ ${effort}${RESET}  ${CONTEXT_COLOR}󰘚 ${context_int}%${RESET}  ${MAGENTA} ${formatted_tokens}${RESET}  ${GREEN} ${formatted_duration}${RESET}${subagents_part}"

elif [ "$cols" -ge 80 ]; then
  # Narrow mode: Compact tokens, no subagents details
  formatted_tokens="$(format_number $total_tokens)"
  formatted_duration="$(format_duration $duration_ms)"

  echo -e "${CYAN}󰚩 ${model}${RESET}  ${EFFORT_COLOR}⚡ ${effort}${RESET}  ${CONTEXT_COLOR}󰘚 ${context_int}%${RESET}  ${MAGENTA} ${formatted_tokens}${RESET}  ${GREEN} ${formatted_duration}${RESET}"

else
  # Ultra-Narrow mode: Show critical stats (Model, Context usage %, Tokens)
  formatted_tokens="$(format_number $total_tokens)"
  
  echo -e "${CYAN}󰚩 ${model}${RESET}  ${CONTEXT_COLOR}󰘚 ${context_int}%${RESET}  ${MAGENTA} ${formatted_tokens}${RESET}"
fi
