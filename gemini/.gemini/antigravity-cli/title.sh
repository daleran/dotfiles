#!/bin/bash
# title.sh - Custom terminal title script for Antigravity CLI

# Read the JSON payload from stdin
input=$(cat)

# Extract fields gracefully with fallback values
state=$(echo "$input" | jq -r '.agent_state // "idle"')
[ "$state" = "null" ] && state="idle"

# Extract active tool and first background task name
active_tool=$(echo "$input" | jq -r '.active_tool // ""')
if [ "$active_tool" = "null" ] || [ "$active_tool" = "None" ]; then
  active_tool=""
fi

task_name=$(echo "$input" | jq -r '.background_tasks[0].name // ""')
[ "$task_name" = "null" ] && task_name=""

# Determine the working context string (Option 1: Smart Context-Aware)
if [ -n "$active_tool" ]; then
  working_on=" (${active_tool})"
elif [ -n "$task_name" ]; then
  working_on=" [${task_name}]"
elif [ "$state" = "thinking" ]; then
  working_on=" (thinking)"
else
  working_on=""
fi

# Extract VCS branch with fallback to native git
branch=$(echo "$input" | jq -r '.vcs.branch // ""')
if [ "$branch" = "null" ] || [ -z "$branch" ]; then
  # Fallback to native git command if in a repository
  if command -v git &>/dev/null; then
    branch=$(git branch --show-current 2>/dev/null)
  fi
fi

# Construct the branch portion of the title
if [ -n "$branch" ]; then
  vcs_part=" (${branch})"
else
  vcs_part=""
fi

pending=$(echo "$input" | jq -r '.tool_confirmation_pending // .confirmation_pending // false')

# Prepend [!] if a tool confirmation is pending
if [ "$pending" = "true" ]; then
  prefix="[!] "
else
  prefix=""
fi

# Print the final formatted title
echo "${prefix}agy${working_on}${vcs_part} - ${state}"
