function wt --description "Fuzzy-switch to an existing git worktree in a new zellij tab"
    if not type -q fzf
        echo "ERROR: fzf not installed"
        return 1
    end

    set -l worktrees (git worktree list --porcelain 2>/dev/null | string match -r '^worktree (.+)$' | string replace -r '^worktree ' '')
    if test -z "$worktrees"
        echo "ERROR: no worktrees found (not in a git repo?)"
        return 1
    end

    set -l selected (printf '%s\n' $worktrees | fzf \
        --prompt="Worktree> " \
        --header="Select worktree" \
        --preview="git -C {} log --oneline -10 2>/dev/null || echo 'No commits yet'")

    if test -z "$selected"
        return 0
    end

    set -l tab_name (basename "$selected")
    if set -q ZELLIJ
        zellij action new-tab --name "$tab_name" --cwd "$selected"
    else
        cd "$selected"
    end
end
