# Cloud CLIs

`aws` and `kubectl` are read-only. Reads (`describe`, `get`, `list`, `logs`) are fine.
Anything that creates, changes, or deletes state: stop and ask me to run it.

# Prompt Aliases

- DTAA: Does this add anything?
- MTOS: Make this one sentence.
- SDTS: Slim down this selection.
- WDYT: What do you think?

# Pull Requests

- If a `PULL_REQUEST_TEMPLATE` file exists in the repo (check `.github/`), use it as the PR description template when creating pull requests.

# Code Comments

Comment what the code can't say. Default to ONE line, BLUF.

- Explain _why_, or what's non-obvious — never restate what the code shows.
- Hard limit: 2 lines. Need more? Cut it, or move prose to a doc/docstring.
- No teaching, history, or narrating the change you just made.

```
Bad:  // QGIS-style: a plain click flips ONLY this group's flag; descendants
      // keep their stored visibility and are gated by flatVisibleLayers...
Good: // Plain click flips only this group; Cmd/Ctrl cascades the subtree.
```

# "Comment into Code" Refactoring Opportunities

Consider if a comment, especially a weirdly specific or tortuous one, is
actually a code smell flagging that code doesn't by itself convey the story.

This is part of a more general guideline: would the code we are adding have been
improved by first modifying the API that we are calling into? Especially true if
the API is in the same codebase, thus something we can easily change.

A trivial example, take this code:
```javascript
flush();
lock(); // always lock after flush!
```

If we added new flushAndLock() function, the code is cleaner AND needs no comment:
flushAndLock();

# Working agreement

**Ask first, don't investigate first.** When something is ambiguous, blocked, or looks wrong, ask one
sentence and wait. Don't go find the answer yourself.

- Reading what the change in front of you needs is fine and needs no permission. Open-ended discovery
  is not — if you're about to sweep the repo or the cluster to settle a question I could answer in ten
  seconds, ask me.
- Subagents are allowed, but launching one to go find something out is this same mistake at larger
  scale. Propose it first, then launch it.
