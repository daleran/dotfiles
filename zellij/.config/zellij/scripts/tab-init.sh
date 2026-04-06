#!/usr/bin/env bash
# Save to: ~/.config/zellij/scripts/tab-init.sh
# chmod +x ~/.config/zellij/scripts/tab-init.sh
#
# This runs as the terminal pane in tab 1.
# On startup: renames all tabs, then drops into fish.

DIRS=(
    "$HOME/localdev/wofstack"
    "$HOME/localdev/wofstack1"
    "$HOME/localdev/wofstack2"
    "$HOME/localdev/wofstack3"
    "$HOME/localdev/wofstack4"
    "$HOME/localdev/wofstack5"
    "$HOME/localdev/wofstack6"
    "$HOME/localdev/wofstack7"
)

# Only run the rename cycle once (skip if ZELLIJ_TABS_NAMED is set)
if [ -z "$ZELLIJ_TABS_NAMED" ]; then
    export ZELLIJ_TABS_NAMED=1
    sleep 1.5  # let zellij fully start

    for i in "${!DIRS[@]}"; do
        tab_num=$((i + 1))
        dir="${DIRS[$i]}"
        dir_name=$(basename "$dir")
        branch=$(git -C "$dir" branch --show-current 2>/dev/null)

        if [ -n "$branch" ]; then
            tab_name="$dir_name [$branch]"
        else
            tab_name="$dir_name"
        fi

        zellij action go-to-tab "$tab_num"
        sleep 0.15
        zellij action rename-tab "$tab_name"
    done

    # Return to first tab
    zellij action go-to-tab 1
fi

# Hand off to fish
exec fish
