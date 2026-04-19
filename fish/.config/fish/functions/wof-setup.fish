function wof-setup --description "One-time setup: create ~/w1-~/w7 worktrees, databases, and .env files"
    set -l main_repo "$HOME/wofstack"

    if not test -d "$main_repo/.git"
        echo "ERROR: $main_repo is not a git repo — clone wofstack there first"
        return 1
    end

    if not test -f "$main_repo/.env"
        echo "ERROR: $main_repo/.env missing — cannot patch DB_DATABASE without a template"
        return 1
    end

    pushd "$main_repo" >/dev/null

    for i in (seq 1 7)
        set -l worktree "$HOME/w$i"
        set -l branch "agent-$i"
        set -l db "wofstack_w$i"

        if test -d "$worktree"
            echo "• w$i: worktree exists, skipping add"
        else
            git worktree add "$worktree" -b "$branch"
            and echo "✓ w$i: worktree created ($branch)"
            or begin
                echo "ERROR: git worktree add failed for w$i"
                popd >/dev/null
                return 1
            end
        end

        if createdb "$db" 2>/dev/null
            echo "✓ w$i: database $db created"
        else
            echo "• w$i: database $db already exists"
        end

        cp "$main_repo/.env" "$worktree/.env"
        sed -i "s/^DB_DATABASE=.*/DB_DATABASE=$db/" "$worktree/.env"
        if not grep -q "^DB_DATABASE=$db\$" "$worktree/.env"
            echo "ERROR: .env patch failed for w$i — check DB_DATABASE line in $main_repo/.env"
            popd >/dev/null
            return 1
        end
    end

    popd >/dev/null
    echo "✓ wof-setup complete"
end
