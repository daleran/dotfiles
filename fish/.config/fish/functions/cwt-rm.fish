function cwt-rm --description "Remove a worktree and its dedicated database"
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
    set -l repo_parent (dirname "$repo_root")
    set -l worktree "$repo_parent/$repo_name-$branch"
    set -l db_suffix (string replace -ra '[^a-zA-Z0-9]' _ -- "$branch" | string lower)
    set -l db "$repo_name"_"$db_suffix"

    read -l -P "Remove worktree $worktree and drop database $db? [y/N] " confirm
    if not string match -qi 'y*' -- "$confirm"
        echo "aborted"
        return 1
    end

    git -C "$repo_root" worktree remove "$worktree" --force
    and echo "✓ Removed worktree: $worktree"

    if dropdb "$db" 2>/dev/null
        echo "✓ Dropped database: $db"
    else
        echo "• Database $db did not exist"
    end
end
