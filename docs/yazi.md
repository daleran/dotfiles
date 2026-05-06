# Yazi

File manager. Config: `yazi/.config/yazi/`.

Non-default settings: ratio `[0, 1, 3]` (no parent pane, wide preview), natural sort, hidden files shown, preview word-wrap on.

---

## Process

| Key | Action |
|-----|--------|
| `q` | Quit |
| `Q` | Quit without writing CWD file |
| `Ctrl-c` | Close tab |
| `Ctrl-z` | Suspend |
| `Esc` | Escape / cancel |

---

## Navigation

| Key | Action |
|-----|--------|
| `j` / `k` | Next / prev item |
| `h` / `l` | Go to parent / child directory |
| `H` / `L` | Back / forward in history |
| `gg` / `G` | Top / bottom of list |
| `Ctrl-u` / `Ctrl-d` | Half page up / down |
| `Ctrl-b` / `Ctrl-f` | Full page up / down |

---

## Selection

| Key | Action |
|-----|--------|
| `Space` | Toggle selection + move down |
| `v` | Enter visual selection mode |
| `V` | Visual unset mode |
| `Ctrl-a` | Select all |
| `Ctrl-r` | Invert selection |

---

## Operations

| Key | Action |
|-----|--------|
| `o` / `Enter` | Open |
| `O` / `Shift-Enter` | Open (interactive) |
| `y` | Yank (copy) |
| `x` | Cut |
| `p` | Paste |
| `P` | Paste (overwrite) |
| `Y` / `X` | Cancel yank / cut |
| `d` | Move to trash |
| `D` | Delete permanently |
| `a` | Create file/directory |
| `r` | Rename (cursor before extension) |
| `-` | Create absolute symlink |
| `_` | Create relative symlink |
| `Ctrl--` | Create hard link |

---

## Shell

| Key | Action |
|-----|--------|
| `;` | Shell (interactive) |
| `:` | Shell (blocking + interactive) |

---

## Preview

| Key | Action |
|-----|--------|
| `K` | Seek preview up 5 lines |
| `J` | Seek preview down 5 lines |
| `Tab` | Spot (inspect) hovered file |

---

## Search & Filter

| Key | Action |
|-----|--------|
| `s` | Search via `fd` |
| `S` | Search via `rg` (ripgrep) |
| `Ctrl-s` | Cancel search |
| `f` | Filter (smart case) |
| `/` | Find next |
| `?` | Find previous |
| `n` / `N` | Next / prev found item |
| `z` | Jump via fzf |
| `Z` | Jump via zoxide |

---

## Copy Path

Press `c` then:

| Key | Copies |
|-----|--------|
| `c` | Full path |
| `d` | Directory name |
| `f` | File name with extension |
| `n` | File name without extension |

---

## Sorting

Press `,` then:

| Key | Sort by |
|-----|---------|
| `m` / `M` | Modified time (asc / desc) |
| `b` / `B` | Birth time (asc / desc) |
| `e` / `E` | Extension (asc / desc) |
| `a` / `A` | Alphabetical (asc / desc) |
| `n` / `N` | Natural (asc / desc) |
| `s` / `S` | Size (asc / desc) |
| `r` | Random |

---

## Linemode

Press `m` then:

| Key | Show |
|-----|------|
| `s` | File size |
| `p` | Permissions |
| `b` | Birth time |
| `m` | Modified time |
| `o` | Owner |
| `n` | None |

---

## Goto

Press `g` then:

| Key | Go to |
|-----|-------|
| `h` | `~` (home) |
| `c` | `~/.config` |
| `d` | `~/Downloads` |
| `Space` | Interactive jump |
| `f` | Follow symlink target |

---

## Tabs

| Key | Action |
|-----|--------|
| `t` | New tab at current CWD |
| `1`–`9` | Switch to tab N |
| `[` / `]` | Previous / next tab |
| `{` / `}` | Swap tab with prev / next |

---

## Other

| Key | Action |
|-----|--------|
| `.` | Toggle hidden files |
| `w` | Task manager |
| `~` / `F1` | Help |
