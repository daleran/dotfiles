function cwt --description "Create a worktree for a branch with its own DB, .env, and dev port"
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

    if test -d "$worktree"
        echo "ERROR: $worktree already exists"
        return 1
    end

    set -l used_ports
    for wt in (git -C "$repo_root" worktree list --porcelain | string match -r '^worktree (.+)' | string replace -r '^worktree ' '')
        if test -f "$wt/.env"
            set -l p (grep -oP '^APP_PORT=\K[0-9]+' "$wt/.env" 2>/dev/null)
            test -n "$p"; and set -a used_ports $p
        end
    end
    set -l port 8100
    while contains -- $port $used_ports; or ss -ltn 2>/dev/null | grep -q ":$port "
        set port (math $port + 1)
    end

    git -C "$repo_root" worktree add "$worktree" -b "$branch"
    or return 1

    if test -f "$repo_root/.env"
        cp "$repo_root/.env" "$worktree/.env"
        sed -i "s/^DB_DATABASE=.*/DB_DATABASE=$db/" "$worktree/.env"
        if not grep -q "^DB_DATABASE=$db\$" "$worktree/.env"
            echo "ERROR: .env patch failed — check DB_DATABASE in $repo_root/.env"
            return 1
        end
        if grep -q "^APP_PORT=" "$worktree/.env"
            sed -i "s/^APP_PORT=.*/APP_PORT=$port/" "$worktree/.env"
        else
            echo "APP_PORT=$port" >> "$worktree/.env"
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
    echo "✓ Port:     $port (serve with: php artisan serve --port=$port)"

    if set -q ZELLIJ
        zellij action new-tab --name "$branch" --cwd "$worktree"
    end
end
