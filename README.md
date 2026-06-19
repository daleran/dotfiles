# Dotfiles

A high-performance development environment for Ubuntu, featuring Fish shell, Neovim, Zellij, and a custom Git worktree workflow.

## 🚀 Quick Start

To set up a fresh Ubuntu machine with these dotfiles:

```bash
git clone https://github.com/sdavis/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

**Post-install:** Log out and log back in to activate the Fish shell as default.

## 📦 What's Included?

### Core Stack
- **Shell:** [Fish](docs/fish.md) with [Fisher](https://github.com/jorgebucaran/fisher) and `nvm.fish`.
- **Editor:** [Neovim](docs/nvim.md) (Unstable PPA) with Lazy.nvim, Mason, and LSP.
- **Terminal:** [Alacritty](docs/alacritty.md) (Ayu-style theme, JetBrainsMono Nerd Font).
- **Multiplexer:** [Zellij](docs/zellij.md) with custom project and worktree layouts.
- **File Manager:** [Oil.nvim](docs/nvim.md) (edit the filesystem like a Neovim buffer).

### Workflow & Tools
- **[Git Worktrees](docs/worktrees.md):** Custom functions (`cwt`, `cwt-rm`, `wt`) for parallel branch development with independent databases and ports.
- **AI Integration:** Claude Code CLI and Neovim review markers.
- **Utilities:** `fzf`, `ripgrep`, `fd`, `gh`, `pgcli`, `composer`, `nvm` (Node 22).

## 📂 Project Structure

- `alacritty/`: Terminal configuration.
- `claude/`: Claude Code custom commands, markers, and settings.
- `docs/`: Detailed reference documentation for each tool.
- `fish/`: Shell functions, aliases, and completions.
- `gemini/`: Gemini/Antigravity user settings and keybindings.
- `nvim/`: Neovim configuration (Lua).
- `zellij/`: Multiplexer layouts and configuration.


## 🛠️ Requirements
- **OS:** Ubuntu (tested on 22.04 and 24.04).
- **Sudo:** Required for `apt` installations and changing the default shell.

## 📖 Documentation
See the [docs/](docs/README.md) directory for detailed keybindings and workflow guides.
