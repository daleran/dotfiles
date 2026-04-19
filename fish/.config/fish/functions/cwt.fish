function cwt --description "Create a personal feature worktree (outside the w1-w7 agent pool) with its own DB and a zellij tab"
    set -l branch $argv[1]
    if test -z "$branch"
        echo "Usage: cwt <branch-name>"
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

    git worktree add "$worktree" -b "$branch"
    or return 1

    if test -f "$repo_root/.env"
        cp "$repo_root/.env" "$worktree/.env"
        sed -i "s/^DB_DATABASE=.*/DB_DATABASE=$db/" "$worktree/.env"
        if not grep -q "^DB_DATABASE=$db\$" "$worktree/.env"
            echo "ERROR: .env patch failed — check DB_DATABASE in $repo_root/.env"
            return 1
        end
    else
        echo "• no .env in $repo_root, skipping"
    end

    if createdb "$db" 2>/dev/null
        echo "✓ Database: $db"
    else
        echo "• Database $db already exists"
    end

    echo "✓ Worktree: $worktree"
    echo "✓ Branch:   $branch"

    if set -q ZELLIJ
        zellij action new-tab --name "$branch" --cwd "$worktree"
    end
end
