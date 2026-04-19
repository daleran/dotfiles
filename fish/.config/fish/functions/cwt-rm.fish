function cwt-rm --description "Remove a personal feature worktree and its dedicated database"
    set -l branch $argv[1]
    if test -z "$branch"
        echo "Usage: cwt-rm <branch-name>"
        return 1
    end

    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    if test -z "$repo_root"
        echo "ERROR: not inside a git repo"
        return 1
    end

    set -l repo_name (basename "$repo_root")
    set -l worktree "$HOME/$repo_name-$branch"
    set -l db_suffix (string replace -ra '[^a-zA-Z0-9]' _ -- "$branch" | string lower)
    set -l db "$repo_name"_"$db_suffix"

    if string match -q "wofstack_w*" -- "$db"
        echo "ERROR: refusing to touch agent-pool slot ($db). Use wof-reset instead."
        return 1
    end

    read -l -P "Remove worktree $worktree and drop database $db? [y/N] " confirm
    if not string match -qi 'y*' -- "$confirm"
        echo "aborted"
        return 1
    end

    git worktree remove "$worktree" --force
    and echo "✓ Removed worktree: $worktree"

    if dropdb "$db" 2>/dev/null
        echo "✓ Dropped database: $db"
    else
        echo "• Database $db did not exist"
    end
end
