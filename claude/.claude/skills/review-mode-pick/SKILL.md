---
name: review-mode-pick
description: After a feature is done, choose between Mode A (REVIEW: markers, no PR) and Mode B (draft PR on GitHub). Triggered by "open this for review", "set up review", or similar after a task finishes.
---

# /review-mode-pick

## 1. Inspect the diff

Run `git diff main...HEAD --stat` (or the appropriate base branch) to see scope. Also check for migrations, schema files, or public API surface changes.

## 2. Choose a mode

**Mode A — markers (no PR):** if the change is small — roughly a handful of files, no schema/migrations, no public API surface, no changes the team would expect to see in a PR.

State the choice in one line, e.g.:

> Small change (3 files, no migrations). Using Mode A — drop `REVIEW:` markers in source, then `/address-reviews` to address them.

Stop here for Mode A. The user handles the rest.

**Mode B — draft PR:** if the change is non-trivial, touches anything user-visible, involves schema or migrations, or warrants a durable record.

Push the branch and open a draft PR:

```
gh pr create --draft --fill
```

Report the PR number and URL. State the mode choice in one line, e.g.:

> Non-trivial change (12 files, includes migration). Opening draft PR. Use `:Octo pr list` → `<space>ca` to leave inline comments, then `/address-pr <N>` to address them.

## Notes

- This is a heuristic, not a hard rule. Always invite the user to override: "Override? Just say Mode A or Mode B."
- If already on a pushed branch with an open PR, default to Mode B regardless of size.
