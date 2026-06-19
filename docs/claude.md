# Claude Code Settings

Claude Code configuration is managed in `~/.claude/settings.json`, stowed from `claude/.claude/settings.json`.

## Customizations

### Window Title Bar Integration

Because Claude Code does not support a native window title command block in `settings.json`, terminal window/tab title formatting is dynamically injected directly inside the custom status line script (`statusline.sh`).
It writes the Xterm title ANSI escape sequence (`\033]0;...\007`) directly to `/dev/tty`, bypassing Claude's output capture to seamlessly update the window title on every state change.

- **Format**: `[!] claude (working_on) (vcs_branch) - agent_state`
  - `[!]` prepended if tool confirmation is pending.
  - `(working_on)` displays the active tool name, background task, or `(thinking)`.
  - `(vcs_branch)` displays the current git branch name with native git fallback.
  - `- agent_state` displays the current state (e.g., `idle`, `thinking`, `working`).

### TUI Status Line Script (`statusline.sh`)

Highly polished TUI status line mirroring Antigravity with ANSI colors matching the `ayu-dark` Alacritty color theme, and including estimated session costs.

- **Location**: `~/.claude/statusline.sh` (Stowed from `claude/.claude/statusline.sh`)
- **Format**:
  `󰚩 [Model]   ⚡ [Effort]   󰘚 [Usage]%    [Tokens]    [Duration]   🪙 $[Cost]    [Count] ([Status])`
- **Color Coding**:
  - `model`: Cyan
  - `effort`: Dynamically colored based on effort level:
    - High/Max: Bold Red
    - Medium: Bold Yellow
    - Low/Auto: Bold Green
  - `context usage`: Dynamically colored based on threshold:
    - &ge; 80%: Bold Red (Dangerous usage)
    - &ge; 50%: Bold Yellow (Warning usage)
    - &lt; 50%: Bold Green (Safe usage)
  - `tokens`: Magenta (Formatted in thousands/millions with input/output split)
  - `duration`: Green (Elapsed session duration converted to standard human-readable format)
  - `cost`: Gold/Yellow (Client-side estimate of cumulative session costs formatted to 4 decimal places)
  - `subagents`: Blue (Dynamic list count with running/waiting split, hidden if zero)

- **Responsive Design**: Dynamically adjusts layout complexity based on active terminal width (queried from `/dev/tty`) to prevent visual clipping or screen corruption on split screens:
  * **Wide Mode (&ge; 110 columns)**: Shows full detailed layout (detailed tokens split `In/Out`, compact subagents status).
  * **Narrow Mode (80 - 109 columns)**: Core metrics (Model, Effort, Context %, compact Tokens, Duration, Cost). Drops subagent details.
  * **Ultra-Narrow Mode (< 80 columns)**: Minimalist layout showing only essential stats (Model, Context %, compact Tokens, Cost) to fit neatly in very narrow split-panes.

---

## Configuration

In `~/.claude/settings.json`:

```json
  "statusLine": {
    "type": "command",
    "command": "~/.claude/statusline.sh",
    "enabled": true
  }
```

### Other settings.json keys

| Key | Value | Notes |
|-----|-------|-------|
| `model` | `opus` | Default model for new sessions |
| `theme` | `auto` | Follows terminal light/dark |
| `permissions.allow` | read-only Bash allow list | Pre-approves safe commands (`git status/log/diff/show/branch/blame`, `find`, `grep`, `rg`, `ls`, `cat`, `head`, `tail`, `wc`, `which`, `echo`, `pwd`, `date`, `whoami`) to cut down on prompts |
| `enabledPlugins` | `slack@claude-plugins-official` | Slack plugin enabled |
| `extraKnownMarketplaces` | `claude-code-plugins` → `anthropics/claude-code` | Registers the official plugin marketplace |
| `agentPushNotifEnabled` | `true` | Push notifications for agent events |
| `skipAutoPermissionPrompt` | `true` | Skip the automatic permission prompt |
| `voiceEnabled` | `true` | Voice input enabled |

### Keybindings (`~/.claude/keybindings.json`)

| Key | Action |
|-----|--------|
| `Alt+M` | Open model picker |
