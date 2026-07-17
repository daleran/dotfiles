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
| `zav` | `aiventure` | `~/localdev/aiventure` |

---

## Editor & Claude Launchers

| Command | Description |
|---------|-------------|
| `noil` | Open Neovim Oil in the current directory |
| `ndiff` | Open Neovim Diffview against `main` |
| `nman` | Open Neovim Oil in the dotfiles `docs/` directory |
| `cplan [task]` | Launch Claude (opusplan, plan mode); with a task number, runs `/ipl <task>` as the first prompt |

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
| `w1`–`w12` | `cd` to `~/localdev/wofstack`, `wofstack2`, … `wofstack12`; optional arg renames the focused zellij tab (`w2 EAX15` → tab `w2:EAX15`) |
| `wstat` | List each `w1`–`w12` wofstack dir with its branch (`*` on the dir = uncommitted changes) |
| `rsh` | `gcloud compute ssh` |
| `clswch` | Switch Claude SSO accounts (logout + re-login) |

---

## Environment

- Editor: `nvim` (`$EDITOR` and `$VISUAL`)
- Node: managed via nvm, default version 22
- `~/.local/bin` on PATH
- Secret env vars: `.env.fish` — sourced at startup if present (gitignored). Holds DB creds (`PGSQL_READONLY_*`, `PGSQL_PROD_*`), tokens, etc. — never commit it.
- Plugins: `jorgebucaran/fisher` (plugin manager), `jorgebucaran/nvm.fish`
