# Neovim config

## Key bindings

### Git / diff

| Key | Action |
|-----|--------|
| `<leader>gd` | Open diffview against `main` |
| `<leader>gh` | File history for current file (diffview) |
| `<leader>gc` | Close diffview |
| `<leader>go` | PR list (Octo) |
| `<leader>gs` | Stage hunk (gitsigns, git buffers only) |
| `<leader>gr` | Reset hunk (gitsigns, git buffers only) |
| `<leader>gp` | Preview hunk (gitsigns, git buffers only) |
| `]h` / `[h` | Next / prev hunk (gitsigns) |

### Octo in-review defaults

| Key | Action |
|-----|--------|
| `<space>ca` | Add review comment |
| `<space>ce` | Edit review comment |
| `<space>cd` | Delete review comment |
| `<space>cs` | Submit review |
| `<space>cr` | React to comment |

Full Octo keymap reference: `:h octo-mappings`

### Telescope

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>fr` | Recent files |

### Other

| Key | Action |
|-----|--------|
| `<leader>e` | File explorer (Oil) |
| `<C-h/j/k/l>` | Window navigation |

## AI review workflow

**Mode A (no PR):** drop `// REVIEW: your note` markers in source, then in the agent pane type `/address-reviews`.

**Mode B (draft PR):** `<leader>go` → pick PR → `<space>ca` for inline comments → `<space>cs` to submit. Then in the agent pane type `/address-pr <N>`.

Commands live in `~/.claude/commands/` (symlinked from `dotfiles/claude/.claude/commands/`).
