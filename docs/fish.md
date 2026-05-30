# Fish Shell

No custom keybindings or abbreviations — uses standard fish defaults. All shortcuts are functions.

---

## Worktree Workflow

| Command | Description |
|---------|-------------|
| `cwt <branch>` | Create a git worktree at `../<repo>-<branch>` with its own DB, `.env`, and dev port. |
| `cwt-rm <branch>` | Remove the worktree and drop its database (prompts for confirmation). |
| `wt` | Fuzzy-pick (fzf) an existing worktree; opens in a new Zellij tab or `cd`s into it. |

See [worktrees.md](worktrees.md) for the full guide.

---

## Zellij Layout Launchers

| Command | Layout | Project |
|---------|--------|---------|
| `zdot` | `dotfiles` | `~/dotfiles` |
| `zwf` | `wofstack` | `~/localdev/wofstack` |
| `zjd` | `javidare` | `~/localdev/javidare` |
| `zlc` | `lcconf` | `~/localdev/lcconf` |
| `zsoc` | `socialdb` | `~/localdev/socialdb` |
| `ziz` | `izaddit` | `~/localdev/izaddit` |
| `zvesp` | `vesper` | `~/localdev/vesper` |
| `zwy` | `wayfarer` | `~/localdev/wayfarer` |

---

## Git Wrappers

| Command | Expands to |
|---------|-----------|
| `gst` | `git status` |
| `gco` | `git checkout` |
| `gf` | `git fetch` |
| `gac "<msg>"` | `git add . && git commit -m "<msg>"` |
| `gpso` | `git push origin` |
| `gplo` | `git pull origin` |
| `gmain` | `git checkout main && git fetch && git pull origin main` |

---

## Database

| Command | Description |
|---------|-------------|
| `dbp` | Open `pgcli` on the **prod** database as the read-only user. Connection details come from `$PGSQL_READONLY_USER`, `$PGSQL_READONLY_PASS`, `$PGSQL_PROD_HOST`, `$PGSQL_PROD_DB` (set in gitignored `.env.fish`). |
| `dbl` | Open `pgcli` on the **local** `tmx` database as the `postgres` superuser. |

---

## Misc

| Command | Description |
|---------|-------------|
| `ll` | `ls -la` |
| `wst` | `cd ~/localdev/wofstack` |
| `rsh` | `gcloud compute ssh` |
| `clswch` | Switch Claude SSO accounts (logout + re-login) |
| `zwf_pane <num> <cmd>` | Run a command inside a wofstack pane and immediately rename its Zellij tab to `w<num>: branch_name` |

---

## Environment

- Editor: `nvim` (`$EDITOR` and `$VISUAL`)
- Node: managed via nvm, default version 22
- `~/.local/bin` on PATH
- Secret env vars: `.env.fish` — sourced at startup if present (gitignored). Holds DB creds (`PGSQL_READONLY_*`, `PGSQL_PROD_*`), tokens, etc. — never commit it.
- Plugins: `jorgebucaran/fisher` (plugin manager), `jorgebucaran/nvm.fish`
