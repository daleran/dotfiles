#!/bin/bash
# title.sh - Custom terminal title script for Antigravity CLI (agy)
# Format:  <dir>   agy   <branch | session | state>
# Echoed for the host's title hook, which sets the terminal title via OSC.
# Third segment: off main -> branch; on main (or no branch) -> session name if
# Antigravity exposes one, otherwise the live agent state.

input=$(cat)

# Current directory name (basename of the workspace dir)
dir_path=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
if [ "$dir_path" = "null" ] || [ -z "$dir_path" ]; then
  dir_path="$PWD"
fi
dir_name=$(basename "$dir_path")

# Git branch (agy provides .vcs.branch; fall back to git)
branch=$(echo "$input" | jq -r '.vcs.branch // ""')
if [ "$branch" = "null" ] || [ -z "$branch" ]; then
  if command -v git &>/dev/null; then
    branch=$(git branch --show-current 2>/dev/null)
  fi
fi

# Session name (if provided) and live agent state (idle/thinking/working/tool_use)
session_name=$(echo "$input" | jq -r '.session_name // ""')
[ "$session_name" = "null" ] && session_name=""
state=$(echo "$input" | jq -r '.agent_state // "idle"')
[ "$state" = "null" ] && state="idle"

# Nerd Font icons: folder (dir), robot (agent), git branch, tag (session), bolt (state)
ICON_DIR=$''
ICON_AGENT=$'\U000f06a9'
ICON_BRANCH=$''
ICON_SESSION=$''
ICON_STATE=$''

title_text="${ICON_DIR} ${dir_name}  ${ICON_AGENT} agy"
# Off main: show the branch. On main (or no branch): session name, else live state.
if [ -n "$branch" ] && [ "$branch" != "main" ]; then
  title_text="${title_text}  ${ICON_BRANCH} ${branch}"
elif [ -n "$session_name" ]; then
  title_text="${title_text}  ${ICON_SESSION} ${session_name}"
else
  title_text="${title_text}  ${ICON_STATE} ${state}"
fi

echo "$title_text"
