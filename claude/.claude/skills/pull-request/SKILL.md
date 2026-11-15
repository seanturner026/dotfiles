---
name: pull-request
description: Write pull request descriptions that respect the repo's template, capture the non-obvious decisions from the conversation, and stay brief. Trigger whenever creating, opening, or drafting a PR (e.g. "open a PR", "gh pr create", "push this up for review", "draft a PR description").
---

# Pull Request Skill

How to write a PR the reviewer will actually want to read. Applies whenever you are about to run `gh pr create`, push a
branch for review, or draft a description the user will paste into GitHub.

## 1. Always use the repo's template if one exists

Before writing a single word of the description, check for a template. Look in this order and use the first one you find:

- `.github/PULL_REQUEST_TEMPLATE.md`
- `.github/pull_request_template.md`
- `.github/PULL_REQUEST_TEMPLATE/*.md` (pick the variant matching the change, else the default)
- `docs/pull_request_template.md`
- `PULL_REQUEST_TEMPLATE.md` at repo root
- `pull_request_template.md` at repo root

If a template exists, **use its exact structure — headings, order, checklist items, HTML comments, everything.** Fill
each section; don't drop sections you think are unnecessary. If a section genuinely doesn't apply, write "N/A" with a
one-line reason instead of deleting it. HTML comment placeholders (`<!-- ... -->`) that are instructions to the author
should be replaced with the answer; other HTML comments stay.

Checklists: check the boxes you actually satisfied, leave the rest unchecked. Don't delete checklist items.

If no template exists, default to a one-line summary, a `## Summary` section, and a `## Test plan` section.

## 2. Capture what actually mattered, not what you did last

The description's job is to give the reviewer the context *you* had when writing the code. That context is in the
conversation, not the diff. The diff shows *what* changed; the description should explain *why* and *what the reviewer
needs to know to trust it*.

Before writing, scan the conversation for:

- **Decisions with alternatives.** "We picked X over Y because Z" is the single most valuable thing you can put in a PR
description. If the user steered you away from an approach, that belongs in the description.
- **Constraints discovered mid-task.** Hidden coupling, an API quirk, a performance gotcha, a migration-ordering
requirement. If it surprised you, it will surprise the reviewer.
- **Scope boundaries.** Things you explicitly did *not* do and why ("didn't touch the retry logic — out of scope, follow-up").
- **Risks or caveats worth testing.** "Assumes X is always true — worth double-checking on staging."
- **Non-obvious correctness arguments.** If a change looks wrong but is right, explain why.

These come from the user's messages and your own reasoning during the task. The diff cannot tell the reviewer any of them.

## 3. Exclude the noise

A PR description is not a changelog. Omit anything the reviewer can see in ten seconds of scrolling the diff, and omit anything that is purely housekeeping.

**Don't mention:**

- Formatting (`terraform fmt`, `gofmt`, `ruff format`, prettier, etc.)
- Linter fixes unless they changed behavior
- Moving an import to the top of the file, sorting imports, removing unused imports
- Renaming a local variable for clarity
- Updating type annotations to newer syntax (`List[X]` → `list[X]`, `Optional[X]` → `X | None`)
- Docstring or comment tweaks
- Trailing newlines, whitespace
- "Refactored X for readability" when readability is the only motivation — the diff speaks for itself
- Running tests / "all tests pass" — CI reports that
- Step-by-step narration of what files you edited

If the entire PR *is* housekeeping (e.g. a dedicated type-annotation cleanup), then describe it — but in one line:
"Migrate type hints to 3.12-native syntax across `foo/`."

## 4. Before you submit

- Re-read the template sections — did you answer each question, or just restate the heading?
- Scan your bullets — does each one tell the reviewer something the diff doesn't?
- Title: under 70 characters, imperative mood ("Add X", "Fix Y"), matching recent PRs' convention (`gh pr list --limit 10`).
- Confirm no conversation artifacts leaked in ("as you asked me to...", "per our earlier discussion...") — the reviewer
wasn't there.
