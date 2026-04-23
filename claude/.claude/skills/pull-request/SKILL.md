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

**Also avoid:**

- Filler: "This PR...", "The purpose of this PR is to...", "In order to...", "It's worth noting that..."
- Restating the title in the first sentence of the body
- Lists of every file touched

## 4. Be brief

Brevity is the soul of wit. Targets:

- **Title:** under 70 characters. Imperative mood ("Add X", "Fix Y", "Rename Z"). Match the repo's convention if recent
PRs show one (conventional commits, ticket prefix, etc. — check `gh pr list --limit 10`).
- **Summary section:** 1–3 bullets or 2–3 sentences. If you can't summarize it that tightly, the PR is probably too big
— flag that to the user.
- **Test plan:** the minimum checks a reviewer should run or verify. Skip it if the template doesn't ask for it and CI
covers everything.
- **Whole description:** past ~200 words without a specific reason (complex migration, security-sensitive change,
multi-step rollout), you're over budget. Cut.

When in doubt, cut. The reviewer can ask.

## 5. Before you submit

- Re-read the template sections — did you answer each question, or just restate the heading?
- Scan your bullets — does each one tell the reviewer something the diff doesn't?
- Check the title against recent PRs for style consistency.
- Confirm no conversation artifacts leaked in ("as you asked me to...", "per our earlier discussion...") — the reviewer
wasn't there.

## Anti-examples

**Bad** (ignores template, fluff, noise, restates the diff):

> ## Summary
> This PR updates the user service to improve the handling of authentication. I refactored the login function, cleaned
> up some imports, fixed formatting, and updated the type hints. All tests pass.
>
> ## Changes
> - Modified `user_service.py`
> - Modified `auth.py`
> - Ran `ruff format`

**Good** (uses template, captures the decision, trims noise):

> ## Summary
> Switch login to verify sessions against Redis instead of the DB. Cuts p99 login latency from ~140ms to ~12ms under
> load.
>
> Kept the DB write for audit purposes — removing it would need a schema change on `login_events`, out of scope here.
>
> ## Test plan
> - [x] Unit tests cover cache hit, cache miss, and Redis-down fallback
> - [ ] Verify on staging that session TTL matches the existing cookie `Max-Age`
