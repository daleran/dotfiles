# Cache to avoid redundant renames
set -g _zellij_last_tab_name ""
 
function _zellij_rename_tab
    if not set -q ZELLIJ; or not set -q ZELLIJ_PANE_ID
        return
    end
 
    # Find the git repo root (or use PWD)
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        return  # not in a git repo, skip
    end
 
    set -l repo_name (basename "$repo_root")
 
    # Only rename for wofstack directories
    # Map directory names to short labels
    set -l short_name
    switch "$repo_name"
        case "wofstack1"
            set short_name "w1"
        case "wofstack2"
            set short_name "w2"
        case "wofstack3"
            set short_name "w3"
        case "wofstack4"
            set short_name "w4"
        case "wofstack5"
            set short_name "w5"
        case "wofstack6"
            set short_name "w6"
        case "wofstack7"
            set short_name "w7"
        case '*'
            return  # not a wofstack dir, don't rename
    end
 
    set -l branch (git branch --show-current 2>/dev/null)
 
    set -l tab_name "$short_name"
    if test -n "$branch"
        set tab_name "$short_name [$branch]"
    end
 
    # Skip if nothing changed
    if test "$tab_name" = "$_zellij_last_tab_name"
        return
    end
    set -g _zellij_last_tab_name "$tab_name"
 
    # Use the zellij-tab-name plugin pipe to rename the correct tab
    zellij pipe --name change-tab-name -- "{\"pane_id\": \"$ZELLIJ_PANE_ID\", \"name\": \"$tab_name\"}" &>/dev/null &
end
 
# Trigger on prompt draw (catches startup + tab focus)
function _zellij_on_prompt --on-event fish_prompt
    _zellij_rename_tab
end
 
# Trigger after commands (catches git checkout, git switch, etc.)
function _zellij_on_postexec --on-event fish_postexec
    _zellij_rename_tab
end
 
# Trigger on directory change
function _zellij_on_cd --on-variable PWD
    _zellij_rename_tab
end
