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
- **fish** — Fish shell: custom functions in `functions/`, completions in `completions/`, theme/env in `conf.d/`, plugin list in `fish_plugins` (managed by Fisher)
- **nvim** — Neovim config using lazy.nvim plugin manager. Entry point is `init.lua`, options/keymaps/autocmds split under `lua/config/`, plugins defined per-concern under `lua/plugins/`
- **yazi** — File manager with ayu-dark flavor
- **zellij** — Terminal multiplexer config (KDL format) with custom layouts and scripts

## Key Details

- Fish plugin manager is **Fisher** (`fish_plugins` is its manifest)
- Neovim uses **lazy.nvim** with plugin specs auto-loaded from `lua/plugins/*.lua`
- Node version managed via **nvm** (fish plugin), defaulting to Node 22
- Default editor is `nvim`
