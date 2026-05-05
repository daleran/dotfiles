---
name: pr-review-address
description: Fetch all unresolved review comments on a GitHub PR and address them in a single pass. Triggered by "address review comments on PR #N", "fix the PR feedback", "address review on #N", or similar.
---

# /pr-review-address

Run these steps in order. Fail loudly — do not silently skip a step.

## 1. Fetch unresolved threads

Use the `gh pr-review` extension to fetch all unresolved inline review comments:

```
gh pr-review review view <N> --unresolved --json
```

One-time install if not present: `gh extension install agynio/gh-pr-review`.

If the PR has no unresolved threads, say so and stop.

## 2. Group by locality

Read all threads. Where multiple comments address adjacent code in the same file, treat them together — one contextual edit can address several related notes.

## 3. Address all threads in a single pass

Make all code changes on the current branch. Do not switch branches or create new commits yet.

For ambiguous comments (the reviewer's intent is unclear from the text alone), do not guess — flag them in the final summary for the user to arbitrate. Leave the thread open on GitHub.

## 4. Reply and resolve each addressed thread

For every thread you addressed, post a reply explaining what was changed, then resolve the thread:

```
gh pr-review review reply <N> --thread <thread-id> --body "..."
gh pr-review review resolve <N> --thread <thread-id>
```

Do not resolve a thread without making a real change and posting a reply.

## 5. Run project checks, commit, push

If `CLAUDE.md` or `AGENTS.md` define test/lint commands, run them. Fix any failures before committing.

Commit all changes with a message that references the PR:

```
Address review feedback on #<N>
```

Push the branch. If the push is rejected (non-fast-forward), stop and report — do not force-push.

## 6. Report

List:
- Which threads were resolved, with a one-line summary of the change made
- Which threads were deferred (ambiguous), with the thread text, so the user can clarify

## Notes

- Never auto-resolve a thread without making a real change and posting a reply. Resolving without acting is worse than leaving it open.
- If a comment is ambiguous, surface it in the summary rather than guessing. The user would rather arbitrate one edge case than silently get the wrong change.
- Do not add interactive confirmation prompts between threads. Batch in, batch out.
