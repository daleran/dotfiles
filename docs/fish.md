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
| `zrep` | `reports` | `~/localdev/reports` |

---

## Editor & AI Launchers

| Command | Description |
|---------|-------------|
| `noil` | Open Neovim Oil in the current directory |
| `ndiff` | Open Neovim Diffview against `main` |
| `nman` | Open Neovim Oil in the dotfiles `docs/` directory |
| `cgo [task]` | Launch Claude (`opus`); with a task number, runs `/igo <task>` as the first prompt |
| `ggo <task>` | Launch Grok with `/igo <task>` as the first prompt (always approve) |
| `xgo <task>` | Launch Codex with `/igo <task>` as the first prompt (auto approve, including Git writes) |

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
| `gmain` / `gm` | `git checkout main && git fetch && git pull origin main` |

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
- `GCP_MCP_TOKEN` — bearer token for the GCP remote MCP servers (`gcp-compute`, `gcp-recommender`). Set at shell start via `gcloud auth application-default print-access-token` so Claude/Grok inherit it; expires ~1h
- Secret env vars: `.env.fish` — sourced at startup if present (gitignored). Holds DB creds (`PGSQL_READONLY_*`, `PGSQL_PROD_*`), tokens, etc. — never commit it.
- Torch / TMX MCP (also from `.env.fish`; Claude, Grok, and Codex MCP configs reference these — **no hardcoded secrets**):
  - `TORCH_MCP_TOKEN` — bare JWT for `https://prm.wordonfire.org/mcp/torch`
  - `TORCH_MCP_AUTH_HEADER` — derived at session start as `Bearer $TORCH_MCP_TOKEN` (see `config.fish`)
  - `TORCH_CF_ACCESS_CLIENT_ID` / `TORCH_CF_ACCESS_CLIENT_SECRET` — Cloudflare **Access service tokens** (not browser/OAuth login) for torch-prod
  - `PGSQL_READONLY_USER` / `PGSQL_READONLY_PASS` / `PGSQL_PROD_HOST` / `PGSQL_PROD_DB` — tmxprod postgres MCP + `dbp`
  - Legacy alias: `TORCH_KEY` mirrors `TORCH_MCP_TOKEN`
- GitHub MCP:
  - `GITHUB_MCP_PAT` — GitHub personal access token (source of truth in `.env.fish`)
  - `GITHUB_MCP_TOKEN` — derived at session start as a copy of `GITHUB_MCP_PAT` (Codex requires this exact name; see `config.fish`)
- Plugins: `jorgebucaran/fisher` (plugin manager), `jorgebucaran/nvm.fish`
