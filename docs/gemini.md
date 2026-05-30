# Gemini / Antigravity CLI

Agentic AI coding assistant. Config lives under `gemini/.gemini/antigravity-cli/`:

| File | Purpose |
|------|---------|
| `settings.json` | Project, telemetry, permissions, status line, title, trusted workspaces |
| `keybindings.json` | Custom key map (see below) |
| `statusline.sh` | Custom TUI status line script |
| `title.sh` | Terminal window/tab title integration |

---

## Settings Overview

- **GCP Project:** `wof-sites` (location: `global`)
- **Telemetry:** Disabled (`"enableTelemetry": false`)
- **Non-workspace access:** Allowed (`"allowNonWorkspaceAccess": true`)
- **Status Line:** Enabled, runs `~/.gemini/antigravity-cli/statusline.sh`
- **Title:** Window/tab title set via `~/.gemini/antigravity-cli/title.sh`
- **Permissions:** Pre-approved allow list of shell commands (git, gh, composer, the
  `vendor/bin/*` test/lint tools, `bin/run-affected-tests`, stow, psql, zellij, nvim, etc.)
- **Trusted Workspaces:**
  - `/home/sdavis/localdev/wofstack`
  - `/home/sdavis/localdev/wofstack-b3-gem`
  - `/home/sdavis/dotfiles`

---

## Custom Keybindings

### Session / CLI

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl-L` | Clear Screen | Clears the terminal screen |
| `Ctrl-C` / `Esc` | Escape | Aborts current prompt/action or closes active view |
| `Ctrl-D` | Exit | Exits the CLI session |
| `Ctrl-Z` | Suspend | Suspends the CLI process |
| `Enter` | Enter | Submits the current prompt |

### Editing

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl-G` | Open Editor | Opens the configured text editor to edit input |
| `Ctrl-V` | Paste | Pastes clipboard content |
| `Ctrl-Shift-Z` | Redo | Redoes last undone edit |
| `Ctrl-_` / `Ctrl-Shift--` | Undo | Undoes last edit |
| `Ctrl-Y` | Yank | Yanks current text block |
| `Alt-Enter` / `Ctrl-J` / `Shift-Enter` | Insert Newline | Inserts a new line instead of submitting |

### Confirmation Prompts

| Key | Action | Description |
|-----|--------|-------------|
| `y` | Yes | Confirms the pending action |
| `n` | No | Rejects the pending action |
| `e` | Edit Command | Edits the proposed command before running |

### Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `↑` / `↓` | Up / Down | Move cursor/selection up or down |
| `←` / `→` | Left / Right | Move cursor left or right |
| `Tab` | Tab | Cycle/advance focus |
| `PgUp` / `Shift-↑` | Page Up | Scroll up one page |
| `PgDown` / `Shift-↓` | Page Down | Scroll down one page |
| `Ctrl-Home` | Go to Top | Jump to the top |
| `Ctrl-End` | Go to Bottom | Jump to the bottom |

### Artifacts & Subagents

| Key | Action | Description |
|-----|--------|-------------|
| `Ctrl-R` | Review Artifact | Opens and reviews the active artifact |
| `Ctrl-O` | Toggle Trajectory | Toggles display of full execution trajectory |
| `Ctrl-K` | Approve Fast | Fast-approves a subagent task |
| `Alt-J` | Jump to Waiting | Jumps to a waiting subagent task |

---

## Config Notes

- This package is managed using GNU Stow under the `gemini` package name.
- It targets `~/.gemini/antigravity-cli/` which is the central directory for Antigravity settings and keymaps.
