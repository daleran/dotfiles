---
name: review-markers
description: Address all REVIEW: markers in the working tree in a single pass. Triggered by "address review markers", "address REVIEW comments", "fix the review notes", or similar.
---

# /review-markers

Run these steps in order. Fail loudly — do not silently skip a step.

## 1. Find all markers

Search the working tree for `REVIEW:` markers using language-appropriate comment syntax. Run a single ripgrep pass covering all variants:

```
rg -n "REVIEW:" --glob '!{.git,vendor,node_modules}'
```

Common prefixes: `// REVIEW:`, `# REVIEW:`, `{{-- REVIEW: --}}`, `<!-- REVIEW: -->`, `-- REVIEW:`, `/* REVIEW:`. The `REVIEW:` substring is the canonical anchor; the prefix is language-specific.

If no markers are found, say so and stop.

## 2. Address every marker

For each marker, treat the comment text as a code review note about the surrounding code — the function, block, or line the marker is attached to. Make the change the reviewer is asking for.

Address all markers in a single editing pass. Do not ask for confirmation between markers.

## 3. Remove the markers

After all changes are made, remove every `REVIEW:` comment line. Leave no markers behind. A second `rg -n "REVIEW:"` run should return empty.

## 4. Run project checks

If `CLAUDE.md` or `AGENTS.md` in the project define test or lint commands, run them now. If they pass, proceed. If they fail, fix the failures before reporting.

If no commands are defined, skip this step.

## 5. Summarize

For each marker that was addressed, report:
- The file and line where the marker was
- What the marker said
- What change was made

One block per marker. This becomes the user's second-pass review.

## Notes

- Never address markers one at a time with confirmation prompts. Batch is the entire point. Start immediately.
- If a marker's intent is genuinely ambiguous (e.g. it says "fix this" with no clear direction), make a reasonable interpretation and flag the uncertainty in the summary — do not stop to ask.
- Never commit automatically after addressing markers. The user reviews the summary and commits when satisfied.
