#!/bin/bash
# title.sh - Custom terminal title script for Antigravity CLI (agy)
# Format:  <dir>   agy   <session-name>
# Echoed for the host's title hook, which sets the terminal title via OSC.

input=$(cat)

# Current directory name (basename of the workspace dir)
dir_path=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // .workspace.cwd // ""')
if [ "$dir_path" = "null" ] || [ -z "$dir_path" ]; then
  dir_path="$PWD"
fi
dir_name=$(basename "$dir_path")

# Human-readable session name (used to tell panes apart)
session_name=$(echo "$input" | jq -r '.session_name // ""')
[ "$session_name" = "null" ] && session_name=""

# Nerd Font icons: folder (dir), robot (agent), tag (session)
ICON_DIR=$''
ICON_AGENT=$'\U000f06a9'
ICON_SESSION=$''

title_text="${ICON_DIR} ${dir_name}  ${ICON_AGENT} agy"
[ -n "$session_name" ] && title_text="${title_text}  ${ICON_SESSION} ${session_name}"

echo "$title_text"
