#!/bin/bash
# title.sh - Custom terminal title script for Antigravity CLI (agy)
# Format:  <dir>   agy   <agent_state>
# Echoed for the host's title hook, which sets the terminal title via OSC.
# Fields per the Antigravity title-command schema: agy exposes a live
# .agent_state (idle/thinking/working/tool_use), which Claude does not.

input=$(cat)

# Current directory name (basename of the workspace dir)
dir_path=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
if [ "$dir_path" = "null" ] || [ -z "$dir_path" ]; then
  dir_path="$PWD"
fi
dir_name=$(basename "$dir_path")

# Live agent state (idle / thinking / working / tool_use)
state=$(echo "$input" | jq -r '.agent_state // "idle"')
[ "$state" = "null" ] && state="idle"

# Nerd Font icons: folder (dir), robot (agent), lightning bolt (state)
ICON_DIR=$''
ICON_AGENT=$'\U000f06a9'
ICON_STATE=$''

echo "${ICON_DIR} ${dir_name}  ${ICON_AGENT} agy  ${ICON_STATE} ${state}"
