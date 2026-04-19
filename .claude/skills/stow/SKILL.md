---
name: stow
description: Re-stow changed dotfiles packages, then commit and push. Run after editing anything under fish/, zellij/, nvim/, yazi/, alacritty/, or any other stow package in this repo.
---

# /stow

Run these steps in order. Fail loudly — do not silently skip a step.

## 1. Determine which packages changed

Look at `git status` and take the unique top-level directory of every modified/untracked path. Those are the stow packages that need re-stowing. Skip `.claude/`, `README*`, and any other non-package top-level entries.

## 2. Re-stow those packages

From the repo root:

```
stow <pkg1> <pkg2> ...
```

Stow is idempotent — existing symlinks are fine, new files get linked. If stow errors with a conflict, stop and surface the error; do not use `--adopt` or `--restow` without explicit confirmation.

## 3. Stage and commit

Stage **only** the intended modified/new files — do **not** use `git add -A` or `git add .`. In particular, skip editor backup files (`*.bak`, `*.swp`) and anything that looks like a secret.

Commit message style used in this repo (check `git log --oneline -5` to match):

- Single-line, imperative mood, concise — e.g. `Add uv environment setup for fish shell`, `Remove gemini tab and reorder workspace stacked panes in vesper layout`.
- Body only when the change genuinely needs explanation — most commits have no body.
- End with the standard `Co-Authored-By: Claude ... <noreply@anthropic.com>` footer.

Use a HEREDOC for the `-m` argument so formatting is preserved.

## 4. Push

```
git push
```

If the branch has no upstream, set it with `-u origin <branch>`. If the push is rejected (non-fast-forward), stop and report — do **not** force-push.

## 5. Report

One short line: the commit SHA, the packages stowed, and "pushed to origin/<branch>". That's it.

## Notes

- Do not ask for confirmation before running — the user invoked `/stow` to skip the prompts. Still stop on errors.
- If there are no changes to commit after stowing, say so and exit — do not make an empty commit.
- The untracked `zellij/.config/zellij/config.kdl.bak` is a known editor backup; never stage it.
