# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GNU Stow-based dotfiles repository. Each top-level directory is a stow package that mirrors the target home directory structure. Stow creates symlinks from `~/.config/<app>/` to the corresponding files here.

## Stow Commands

```bash
# Symlink a package to home directory (e.g., fish configs)
stow fish

# Symlink all packages
stow */

# Remove symlinks for a package
stow -D fish

# Preview what stow would do (dry run)
stow -n -v fish
```

## Architecture

Each package follows the pattern `<package>/.config/<app>/...`, which stow maps to `~/.config/<app>/...` relative to the home directory.

**Packages:**
- **alacritty** — Terminal emulator config (TOML)
- **claude** — Claude Code configuration: custom commands in `.claude/commands/`, custom skills in `.claude/skills/`, and user settings in `.claude/settings.json`
- **fish** — Fish shell: custom functions in `functions/`, completions in `completions/`, theme/env in `conf.d/`, plugin list in `fish_plugins` (managed by Fisher)
- **gemini** — Gemini/Antigravity CLI configuration: user settings and keybindings in `.gemini/antigravity-cli/`
- **nvim** — Neovim config using lazy.nvim plugin manager. Entry point is `init.lua`, options/keymaps/autocmds split under `lua/config/`, plugins defined per-concern under `lua/plugins/`
- **yazi** — File manager with ayu-dark flavor
- **zellij** — Terminal multiplexer config (KDL format) with custom layouts and scripts


## Key Details

- Fish plugin manager is **Fisher** (`fish_plugins` is its manifest)
- Neovim uses **lazy.nvim** with plugin specs auto-loaded from `lua/plugins/*.lua`
- Node version managed via **nvm** (fish plugin), defaulting to Node 22
- Default editor is `nvim`

## Conventions

**Documentation:** Per-tool docs live in `docs/<tool>.md`. When adding a new keybinding, function, or shortcut, update the matching file (e.g., a new Neovim leader key → `docs/nvim.md`; a new fish function → `docs/fish.md`). Match the existing markdown table style.

**Adding a new zellij workspace layout:** A workspace is four coordinated pieces — create all of them, then re-stow (`stow fish zellij`) and commit. For a workspace named `<name>` living in `~/localdev/<name>`, launched by fish command `z<abbr>`:

1. **Layout** — `zellij/.config/zellij/layouts/<name>.kdl`. Copy an existing single-tab layout (e.g. `vesper.kdl`); it uses `cwd="${PROJECT_DIR}"`, so nothing inside changes.
2. **Swap layout symlink** — `zellij/.config/zellij/layouts/<name>.swap.kdl` → `standard.swap.kdl` (`ln -s standard.swap.kdl <name>.swap.kdl`). Every layout has one; without it the workspace loses the shared swap layouts.
3. **Launcher function** — `fish/.config/fish/functions/z<abbr>.fish`. Copy `zvesp.fish`: set `PROJECT_DIR` and run `zellij --layout <name> $argv`.
4. **Docs** — add a row to the launcher table in `docs/fish.md` and the layout table in `docs/zellij.md`.

## AI Workflows

### Mode A — Review markers (no PR needed)
- **Trigger:** If the user asks you to address reviews, or types `/address-reviews`.
- **Action:**
  1. Find all `REVIEW:` comments/markers in the working tree.
  2. Implement the requested changes for each marker in a single pass.
  3. **Crucial:** Delete the `REVIEW:` comments/markers from the source files once addressed.
  4. Run project checks or tests if defined to ensure correctness.
  5. Summarize what changes were made for each marker.

### Mode B — GitHub PR review
- **Trigger:** If the user asks you to address a PR, or types `/address-pr <N>`.
- **Action:**
  1. Fetch unresolved review comments on PR #`<N>` using GitHub CLI (`gh pr view` or API).
  2. Implement the requested changes in a single pass.
  3. Reply to and resolve each addressed thread on GitHub.
  4. Commit and push the changes.

