# Neovim

Leader key: `<Space>`

---

## The 5 Modes

| Mode | Enter | Description |
|------|-------|-------------|
| Normal | `Esc` | Home base. Navigate, delete, run commands. |
| Insert | `i`, `a`, `o` | Type text. |
| Visual | `v`, `V`, `Ctrl-v` | Select characters, lines, or blocks. |
| Command | `:` | Run file/config commands (`:w`, `:q`). |
| Search | `/` or `?` | Find text forward or backward. |

> **Golden Rule:** Always `Esc` back to Normal mode.

---

## Operators + Motions

Pattern: `[number] + operator + motion`

| Operator | Description |
|----------|-------------|
| `d` | Delete |
| `c` | Change (delete + insert) |
| `y` | Yank (copy) |
| `>` / `<` | Indent right / left |
| `=` | Auto-indent |
| `gU` / `gu` | Uppercase / lowercase |

Common combinations:

| Keys | Description |
|------|-------------|
| `dd` / `yy` | Delete / yank line |
| `dw` / `yw` | Delete / yank word |
| `d$` / `y$` | Delete / yank to end of line |
| `diw` / `daw` | Inner word / a word (includes surrounding space) |
| `di"` / `da"` | Inside / including quotes |
| `ci(` / `ci{` | Change inside `()` / `{}` |
| `dG` / `yG` | Delete / yank to end of file |
| `guG` | Lowercase to end of file |
| `3dd` / `5j` | Multiplier: apply to N lines / move N lines |

---

## Insert Mode

| Key | Description |
|-----|-------------|
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at start / end of line |
| `o` / `O` | New line below / above |
| `s` / `S` | Delete char / line + insert |
| `C` | Delete to end of line + insert |
| `gi` | Jump to last insertion point + insert |

---

## Visual Mode

| Key | Description |
|-----|-------------|
| `v` / `V` | Character / line-wise selection |
| `Ctrl-v` | Block (column) selection |
| `o` | Move to other end of selection |
| `~` | Toggle case of selection |
| `I` / `A` | Insert / append in block mode |

> **Block edit:** `Ctrl-v` → select down → `I` → type → `Esc`

---

## Copy, Paste, Undo

| Key | Description |
|-----|-------------|
| `p` / `P` | Paste after / before cursor |
| `"0p` / `"0P` | Paste from yank register (ignores deletes) |
| `"_d` / `"_c` | Delete / change to black hole (preserve yank) |
| `x` / `X` | Delete char under / before cursor |
| `u` / `Ctrl-r` | Undo / redo |
| `U` | Undo all changes on current line |
| `"*y` / `"+y` | Copy to system clipboard |

> `"0` always holds the last yank, even after `d`/`x`.

---

## Commands

| Key | Description |
|-----|-------------|
| `:w` / `:q` | Save / quit |
| `:saveas <file>` | Save as different filename |
| `:wq` / `:q!` | Save & quit / force quit |
| `:noh` | Clear search highlight |
| `:%s/old/new/g` | Search & replace all |
| `:Lazy` / `:Mason` | Plugin manager / LSP manager |
| `:checkhealth` | Diagnose environment |

---

## Movement

### Basic & Words

| Key | Description |
|-----|-------------|
| `h` `j` `k` `l` | Left, down, up, right |
| `w` / `b` | Next / prev word start |
| `e` / `E` | Next word end (`E` ignores punctuation) |
| `W` / `B` | Large word (ignores punctuation) |
| `0` / `$` | Start / end of line |
| `^` / `_` | First non-blank character |

### Vertical & Jumps

| Key | Description |
|-----|-------------|
| `gg` / `G` | Top / bottom of file |
| `{` / `}` | Prev / next empty line |
| `Ctrl-u` / `Ctrl-d` | Half page up / down |
| `zz` / `zt` / `zb` | Center / top / bottom cursor on screen |
| `%` | Jump to matching bracket/paren |
| `''` / ` `` ` | Jump to last / exact position |

### Character Search

| Key | Description |
|-----|-------------|
| `f` / `F` | Find char on line (forward / backward) |
| `t` / `T` | Move to before char (forward / backward) |
| `;` / `,` | Repeat last `f`/`t` search (fwd / rev) |
| `*` / `#` | Find next / prev instance of word under cursor |

---

## Windows & Buffers

| Key | Description |
|-----|-------------|
| `:vs` / `:sp` | Vertical / horizontal split |
| `Ctrl-h/j/k/l` | Navigate between splits |
| `Ctrl-w =` / `o` | Equalize sizes / close others |
| `:bn` / `:bp` | Next / prev buffer |
| `<Tab>` / `<S-Tab>` | Next / prev buffer (Normal mode shortcut) |
| `:bd` | Close buffer |
| `gt` / `gT` | Next / prev tab |

---

## Useful Tricks

| Key | Description |
|-----|-------------|
| `.` | Repeat last change |
| `gg=G` | Auto-indent whole file |
| `ggyG` | Yank entire file to clipboard |
| `ggdGp` | Overwrite file with clipboard content |
| `gv` | Reselect last visual selection |
| `cs"'` | Change surround `"` to `'` (vim-surround) |

---

## Leader Keybindings

### File Navigation

| Key | Description |
|-----|-------------|
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Browse buffers (Telescope) |
| `<leader>fr` | Recent files (Telescope oldfiles) |
| `<leader>e` | File explorer (Oil with auto-opening vertical preview: 30% selector, 70% preview) |
| `-` | Go up a directory (Oil) |
| `<C-p>` | Open/toggle vertical preview in Oil (30% selector, 70% preview) |
| `<leader>sc` | Open notes pad (`~/Documents/notes.md`) |

### Buffer Management

| Key | Description |
|-----|-------------|
| `<leader>bp` | Buffer pick (select buffer by typing hint letter) |
| `<leader>bc` | Buffer pick close (close buffer by typing hint letter) |
| `<leader>bo` | Close all other buffers |
| `<leader>bd` | Close current buffer |

### Git

| Key | Description |
|-----|-------------|
| `<leader>gd` | Diff vs main (`DiffviewOpen main`) |
| `<leader>ge` | Toggle diffview file list |
| `gR` | (In Diffview) Open the file under the cursor full-screen in a new tab at the same line — for dropping `// REVIEW:` markers (see below) |
| `<leader>gh` | File history (`DiffviewFileHistory %`) |
| `<leader>gc` | Close diff view |
| `<leader>go` | PR list (Octo) |
| `]h` / `[h` | Next / prev hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gp` | Preview hunk |

### LSP

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `K` | Hover docs |
| `gr` | References |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |

### Completion (insert mode)

| Key | Description |
|-----|-------------|
| `Ctrl-Space` | Trigger completion |
| `Enter` | Confirm selection |
| `Tab` | Next item / expand snippet |

### Octo (PR review)

| Key | Description |
|-----|-------------|
| `<Space>ca` | Add comment |
| `<Space>ce` | Edit comment |
| `<Space>cd` | Delete comment |
| `<Space>cs` | Submit review |
| `<Space>cr` | React to comment |
| `:Octo review` | Open full interactive PR review mode with file panel and side-by-side diff |
| `:Octo pr diff` | Open PR diff view |

Run `:h octo-mappings` for the full reference.

### Other

| Key | Description |
|-----|-------------|
| `Ctrl-\` | Toggle floating terminal |
| `<leader>tm` | Toggle table mode (markdown files) |

---

## AI Review Workflow

### Mode A — Review markers (no PR needed)

1. Open the diff: `<leader>gd` (`DiffviewOpen main`).
2. While viewing a hunk, press `gR` on the line you want to flag — this pops the
   file open full-screen in a new tab at that exact line.
3. Add a `// REVIEW: your note` comment there (e.g. `// REVIEW: make this a service class`), then save.
4. In the Claude agent pane, run `/address-reviews`.

You can also add `// REVIEW:` comments directly in any source file without going through Diffview.

### Mode B — GitHub PR review

1. `<leader>go` → pick the PR (Octo opens it).
2. `<Space>ca` on a line to add a comment, `<Space>cs` to submit the review batch.
3. In the Claude agent pane, run `/address-pr <N>` where `N` is the PR number.

Slash commands live in `~/.claude/commands/` (symlinked from `dotfiles/claude/.claude/commands/`).

---

## Zellij Integration

These locked-mode global keybindings inside Zellij immediately launch Neovim into specific views:

| Key | Action | Description |
|-----|--------|-------------|
| `Alt e` | Open Neovim in Oil file explorer | Shows directories/files in a 30% left list and 70% right preview pane (matching yazi). |
| `Alt d` | Open Neovim in DiffviewOpen main | Opens Neovim showing all files changed on the current local branch compared to `main`. |
