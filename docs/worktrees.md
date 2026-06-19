# Git Worktree Workflow

Dev setup for parallel branch work using git worktrees, dedicated per-branch databases, and automatic port allocation. Designed for running multiple Claude/Gemini agents against independent copies of the app without the overhead of separate clones.

---

## Mental model

- **Main working copy**: `~/localdev/<repo>` (your normal repo, on whatever branch).
- **Worktrees**: `~/localdev/<repo>-<branch>` — one per active branch, each with its own:
  - Working tree and git index
  - `.env` file (copy of main's with `DB_DATABASE` and `APP_PORT` patched)
  - Postgres database `<repo>_<branch>`
  - Dev server port (auto-allocated from 8100+)

Worktrees are **ephemeral**: spin up when you start a branch, tear down when it's merged or abandoned. Worktrees share git objects with the main working copy — no wasted disk, no repeated clones.

Nothing touches nginx or `/etc/hosts`. Every worktree runs on its own localhost port via `php artisan serve`.

---

## Daily commands

### `cwt <branch>` — create a worktree

```fish
cd ~/localdev/wofstack
cwt remove-customer-part3
```

What it does:
1. Picks the lowest unused port ≥ 8100 by scanning existing worktrees' `.env` files and live listeners.
2. `git worktree add ~/localdev/wofstack-remove-customer-part3 -b remove-customer-part3`
3. Copies `~/localdev/wofstack/.env` → `~/localdev/wofstack-remove-customer-part3/.env`, patches `DB_DATABASE=wofstack_remove_customer_part3` and `APP_PORT=8101` (or whatever was free).
4. `createdb wofstack_remove_customer_part3`.
5. If you're inside Zellij, opens a new tab named `remove-customer-part3` using the `worktree` layout (Oil + Claude/Gemini stack + README pane).

Output:

```
✓ Database: wofstack_remove_customer_part3
✓ Worktree: /home/sdavis/localdev/wofstack-remove-customer-part3
✓ Branch:   remove-customer-part3
✓ Port:     8101 (serve with: php artisan serve --port=8101)
```

Non-alphanumerics in the branch name are turned into `_` for the DB name (`feat/foo` → `wofstack_feat_foo`).

### `cwt-rm <branch>` — destroy a worktree

```fish
cwt-rm remove-customer-part3
```

Prompts for confirmation, then:
1. `git worktree remove ~/localdev/wofstack-<branch> --force`
2. `dropdb wofstack_<branch>`

Safe to re-run — missing worktree or DB is treated as "already gone."

The **branch itself is not deleted**. Do that separately with `git branch -D <branch>` or let it die once merged.

### `wt` — fuzzy switcher

```fish
wt
```

Pipes `git worktree list` through fzf. Selecting one opens it in a new Zellij tab (or `cd`s into it if you're not in Zellij). Preview shows the last 10 commits.

---

## Typical task loop

```fish
# Start work on a new branch
cd ~/localdev/wofstack
cwt fix-subscription-webhook

# Zellij opens a tab. Inside it:
composer install              # only needed the first time; vendor/ is per-worktree
npm install                   # same for node_modules/
php artisan migrate --seed    # or migrate:fresh if you want a clean slate
php artisan serve --port=$APP_PORT

# Hand the branch to Claude in the stacked pane.

# When done:
cd ~/localdev/wofstack
cwt-rm fix-subscription-webhook
git branch -D fix-subscription-webhook  # optional
```

For a parallel agent workflow, keep several `cwt`s alive at once — each agent gets its own tab, DB, and port.

---

## Why `.env` is per-worktree

Git ignores `.env`, so each worktree has its own **independent** copy. This is the critical property that makes the whole thing work:

- Changing `DB_DATABASE` in `wofstack-foo/.env` doesn't touch `~/localdev/wofstack/.env`.
- Different worktrees can point at different DBs, different ports, different third-party test keys, etc.
- `cwt` copies the **main** `~/localdev/wofstack/.env` and patches only `DB_DATABASE` and `APP_PORT`. Everything else (`APP_KEY`, `REDIS_*`, `MAIL_*`, OAuth secrets, etc.) is inherited as-is.

If you later change something in the main `.env` that you want every worktree to pick up, you have to propagate it manually — the copies are snapshots, not symlinks. (Deliberate: worktrees often need to diverge.)

---

## Port allocation

`cwt` picks the lowest free port ≥ 8100 by:
1. Reading `APP_PORT=` from every existing worktree's `.env`.
2. Running `ss -ltn` to skip ports already listening (even if no worktree claims them).

This means:
- Spinning up 3 worktrees in a row gets you 8100, 8101, 8102.
- Killing the middle one and spinning up a new one reuses 8101.
- Nothing enforces that you actually *use* the port — it's a reservation in `.env`, not a lock.

If you need a different base port, edit the `8100` literal in `fish/.config/fish/functions/cwt.fish`.

---

## Troubleshooting

**"Worktree already exists" on `cwt`**: the directory `~/localdev/<repo>-<branch>` exists. Remove it (`cwt-rm <branch>` or `git worktree remove --force`) and retry.

**Branch already exists**: `git worktree add -b` refuses to create a branch that already exists. Check out the existing branch instead: `git worktree add ~/localdev/<repo>-<branch> <branch>` (drop the `-b`). Or rename the branch.

**`.env` patch failed**: `cwt` requires `DB_DATABASE=` to exist on its own line in the main `.env`. Fix the format and retry.

**Port not released**: ports aren't held open after the server stops. If `cwt` still thinks a port is taken, something is actually listening — `ss -ltn | grep :PORT` to find out what.

**Database exists but shouldn't**: `createdb` returns an error on duplicate. `cwt` treats this as "already exists" and continues. If you want a fresh DB, run `dropdb <dbname>` first, then re-run `cwt`.

---

## Source

All of this is implemented in the dotfiles repo:

- `fish/.config/fish/functions/cwt.fish`
- `fish/.config/fish/functions/cwt-rm.fish`
- `fish/.config/fish/functions/wt.fish`
- `zellij/.config/zellij/layouts/worktree.kdl`
