# Global instructions

These apply to every session. Keep each rule short and concrete. They are maintained via `/remember`.

## Workflow

- When I give a task, ask any blocking questions FIRST, before exploring the code. A few quick questions beat a long investigation.
- Shallow read-only skimming to make questions concrete is fine; don't do deep exploration before I've answered.
- Only after questions are answered, do the minimum exploration needed, then propose the direction in a few bullets and wait for my OK.
- Skip this loop only for obvious one-shot changes.
- Before reviewing, answering questions about, or changing anything in a repo (including its PRs), read its CLAUDE.md/AGENTS.md in full first. No exceptions for "just a review".
- Read instruction files (CLAUDE.md, AGENTS.md, READMEs) with the read tool, one file per call, paging with offset until the end. Never `cat` them via bash: truncation keeps only the tail and silently drops the top (where Safety rules usually live).

## Code taste

- Group related values in an enum (or the language's equivalent), not as separate top-level CONSTANTS.

## Communication

<!-- Rules for how to talk to me. Add with /remember when a phrasing or format works well. -->

- Work summaries ("what did I do"): start from my merged PRs on GitHub (`gh search prs --author @me --owner KoBoldMetals --merged --merged-at ">=<date>"`), then use beads (`~/code/kobold-metals-pi`) only to group and add context. Beads steps go stale and miss work, so never drop an item because beads says it's open. Format per item: a short title line, a one-line summary, then `why important: ...` only when the summary doesn't make it obvious (skip it for "Streamlined ..." items). Lead with what it enables, not the mechanism (e.g. "Foundry calls APIs as the user", not "Okta refresh").
- After reading a repo's instruction files, follow its style and doc rules without listing them back to me. Only mention points that change the plan (e.g. "no automated tests, verify on the dev cluster"). Don't: "Note: sections are capped at five lines, comments at one or two lines."
