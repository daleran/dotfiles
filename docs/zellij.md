# Zellij

Default mode: **locked**. Press `Ctrl-g` to enter normal mode; `Ctrl-g` again to return to locked.

---

## Locked Mode (default at startup)

| Key | Action |
|-----|--------|
| `Alt -` | Previous tab |
| `Alt =` | Next tab |
| `Alt 1`–`6` | Jump to tab N |
| `Alt c` | Run Claude (in stacked pane) |
| `Alt d` | Open Neovim in DiffviewOpen main (in stacked pane) |
| `Alt e` | Open Neovim in Oil view (in stacked pane) |
| `Alt g` | Run agy (in stacked pane) |
| `Alt p` | Open a new pane in a right split |
| `Alt r` | Open docs directory in `yazi` (in stacked pane) |
| `Alt s` | New stacked pane |
| `Alt t` | New tab |
| `Alt w` | Open blank Neovim instance in current directory (in stacked pane) |
| `Alt x` | Close focused pane |
| `Alt y` | Open `yazi` file manager in current directory (in stacked pane) |
| `Ctrl-g` | Enter normal mode |

---

## Shared (work in all modes, including locked)

| Key | Action |
|-----|--------|
| `Alt h` / `Alt l` | Move focus left / right |
| `Alt j` / `Alt k` | Move focus down / up |
| `Alt Shift h/j/k/l` (bound as `Alt H/J/K/L`) | Move pane left/down/up/right (reorder stacks, etc.) |
| `Alt Shift ←/↓/↑/→` | Move pane left/down/up/right |
| `Alt [` | Previous swap layout |
| `Alt ]` | Next swap layout |

---

## Normal Mode

| Key | Action |
|-----|--------|
| `Alt f` | Toggle floating pane |
| `Alt n` | New pane |
| `Alt p` | Toggle pane in group |
| `Alt +` / `Alt -` | Increase / decrease pane size |
| `Alt i` / `Alt o` | Move tab left / right |
| `Ctrl-g` | Return to locked mode |
| `Ctrl-q` | Quit Zellij |
| `Ctrl-p` | Pane mode |
| `Ctrl-t` | Tab mode |
| `Ctrl-n` | Resize mode |
| `Ctrl-s` | Scroll mode |
| `Ctrl-h` | Move mode |
| `Ctrl-o` | Session mode |
| `Ctrl-b` | Tmux mode |

---

## Pane Mode (`Ctrl-p`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move focus |
| `n` | New pane |
| `d` | New pane below |
| `r` | New pane right |
| `s` | New stacked pane |
| `f` | Toggle fullscreen |
| `w` | Toggle floating |
| `e` | Embed / float pane |
| `z` | Toggle pane frames |
| `c` | Rename pane |
| `x` | Close pane |
| `Ctrl-p` | Exit mode |

---

## Tab Mode (`Ctrl-t`)

| Key | Action |
|-----|--------|
| `1`–`9` | Go to tab N |
| `h/k` | Previous tab |
| `j/l` | Next tab |
| `n` | New tab |
| `r` | Rename tab |
| `x` | Close tab |
| `b` | Break focused pane to new tab |
| `[` / `]` | Break pane left / right |
| `Ctrl-t` | Exit mode |

---

## Resize Mode (`Ctrl-n`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Increase in direction |
| `H/J/K/L` | Decrease in direction |
| `+` / `-` | Increase / decrease |
| `Ctrl-n` | Exit mode |

---

## Scroll Mode (`Ctrl-s`)

| Key | Action |
|-----|--------|
| `j/k` | Scroll down / up |
| `Ctrl-f` / `Ctrl-b` | Page down / up |
| `d` / `u` | Half page down / up |
| `s` | Enter search |
| `e` | Edit scrollback in `$EDITOR` |
| `Ctrl-c` | Jump to bottom + exit |

### Search (from scroll mode)

| Key | Action |
|-----|--------|
| `n` | Next match |
| `p` | Previous match |
| `c` | Toggle case sensitivity |
| `w` | Toggle whole word |

---

## Move Mode (`Ctrl-h`)

| Key | Action |
|-----|--------|
| `h/j/k/l` | Move pane in direction |
| `n` / `Tab` | Move pane forward |
| `Ctrl-h` | Exit mode |

---

## Session Mode (`Ctrl-o`)

| Key | Action |
|-----|--------|
| `w` | Session manager |
| `d` | Detach |
| `a` | About |
| `c` | Configuration |
| `p` | Plugin manager |
| `Ctrl-o` | Exit mode |

---

## Tmux Mode (`Ctrl-b`)

| Key | Action |
|-----|--------|
| `"` | Split pane down |
| `%` | Split pane right |
| `c` | New tab |
| `,` | Rename tab |
| `[` | Enter scroll mode |
| `n` / `p` | Next / prev tab |
| `z` | Toggle fullscreen |
| `o` | Focus next pane |
| `Ctrl-b` | Send literal Ctrl-b |

---

## Layouts

| Layout | Launcher | Description |
|--------|----------|-------------|
| `project` | `zdot`, `zjd`, `zlc` | Canonical workspace. Set `PROJECT_DIR` env var; fish wrappers do this automatically. |
| `socialdb` | `zsoc` | Workspace + `gemini` tab (nvim+AI) + `terminal` tab. |
| `izaddit` | `ziz` | Workspace + `gemini` tab (nvim+AI) + `terminal` tab. |
| `vesper` | `zvesp` | Workspace with `npm run dev` in 20% bottom-right pane. |
| `wofstack` | `zwf` | Overhauled WofStack workspace: 1 main tab (`w1`: 60% nvim, 40% shell) and 7 agent dev tabs (`w2`–`w8` with diff panes). |
| `wayfarer` | `zwy` | Workspace + `npm-dev` tab (dev:editor, dev:designer, dev). |
| `worktree` | `cwt <branch>` | Single-tab worktree workspace. Used by `cwt` via `zellij action new-tab`. |
| `dev` | — | Generic 70/30 split: nvim + Claude Code. No project. |

All layouts open with: yazi (stacked with a README pane pointing at `~/dotfiles/docs`) on the left 60%, and Claude Code (expanded) + Gemini + blank terminal stacked on the right 80%, with a blank terminal below at 20%.

Cycle through the stack with `Alt j` / `Alt k` (focus down/up within stack), or swap tiled layout views with `Alt [` / `Alt ]`.

### Standard Swap Layouts

All layouts share a standard, unified set of swap layouts via symlinked companion `.swap.kdl` files pointing to `standard.swap.kdl`. You can cycle through them using `Alt [` and `Alt ]`:

1. **Standard** (default): Left side gets 60% of the screen. Right side gets 40%. When there are 3 or more panes, the right side automatically stacks additional panes.
2. **Vertical 50/50**: Split 50% left and 50% right. When there are 3 or more panes, the right side automatically stacks additional panes.
3. **Horizontal 50/50**: Split 50% top and 50% bottom. When there are 3 or more panes, the bottom side automatically stacks additional panes.
4. **Stacked**: All panes are vertically stacked on top of each other.

### Adding a new project launcher

Create `fish/.config/fish/functions/z<name>.fish`:

```fish
function z<name> --description 'zellij <name> workspace'
    set -gx PROJECT_DIR ~/localdev/<name>
    zellij --layout project $argv
end
```

If the project needs extra tabs, create `zellij/.config/zellij/layouts/<name>.kdl` by copying `project.kdl` and appending the extra tab blocks. Point the fish wrapper at `--layout <name>` instead.
