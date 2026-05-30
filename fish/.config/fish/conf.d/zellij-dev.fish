set -g _zellij_last_tab_name ""

function _zellij_rename_tab
    if not set -q ZELLIJ; or not set -q ZELLIJ_PANE_ID
        return
    end

    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        return
    end

    set -l repo_name (basename "$repo_root")

    if not string match -q "wofstack*" -- "$repo_name"
        return
    end

    set -l branch (git branch --show-current 2>/dev/null)
    if test -z "$branch"
        return
    end

    set -l tab_name ""
    if string match -r '^wofstack(\d+)$' "$repo_name" >/dev/null
        set -l num (string replace -r '^wofstack(\d+)$' '$1' "$repo_name")
        set tab_name "w$num: $branch"
    else if test "$repo_name" = "wofstack"
        set tab_name "w1: $branch"
    else
        set tab_name "$branch"
    end

    if test "$tab_name" = "$_zellij_last_tab_name"
        return
    end
    set -g _zellij_last_tab_name "$tab_name"

    zellij pipe --name change-tab-name -- "{\"pane_id\": \"$ZELLIJ_PANE_ID\", \"name\": \"$tab_name\"}" &>/dev/null &
end

function zwf_pane --description 'Run a command inside a wofstack pane and rename the tab'
    set -l num $argv[1]
    set -l cmd $argv[2..-1]

    if set -q ZELLIJ; and set -q ZELLIJ_PANE_ID
        set -l branch (git branch --show-current 2>/dev/null)
        if test -n "$branch"
            zellij pipe --name change-tab-name -- "{\"pane_id\": \"$ZELLIJ_PANE_ID\", \"name\": \"w$num: $branch\"}" &>/dev/null &
        end
    end

    exec $cmd
end

function _zellij_on_prompt --on-event fish_prompt
    _zellij_rename_tab
end

function _zellij_on_postexec --on-event fish_postexec
    _zellij_rename_tab
end

function _zellij_on_cd --on-variable PWD
    _zellij_rename_tab
end
