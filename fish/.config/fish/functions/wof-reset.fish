function wof-reset --description "Reset a wofstack worktree slot (discards local changes, refreshes .env, migrate:fresh)"
    set -l i $argv[1]
    if not string match -qr '^[1-7]$' -- "$i"
        echo "Usage: wof-reset <1-7>"
        return 1
    end

    set -l worktree "$HOME/w$i"
    set -l main_repo "$HOME/wofstack"
    set -l db "wofstack_w$i"

    if not test -d "$worktree"
        echo "ERROR: $worktree does not exist — run wof-setup first"
        return 1
    end

    pushd "$worktree" >/dev/null

    git reset --hard
    git clean -fd

    cp "$main_repo/.env" "$worktree/.env"
    sed -i "s/^DB_DATABASE=.*/DB_DATABASE=$db/" "$worktree/.env"
    if not grep -q "^DB_DATABASE=$db\$" "$worktree/.env"
        echo "ERROR: .env patch failed for w$i — aborting reset"
        popd >/dev/null
        return 1
    end

    if test -f artisan
        php artisan migrate:fresh --force
        or begin
            echo "ERROR: migrate:fresh failed for w$i"
            popd >/dev/null
            return 1
        end
    else
        echo "• no artisan found, skipping migrate:fresh"
    end

    popd >/dev/null
    echo "✓ w$i reset"
end
