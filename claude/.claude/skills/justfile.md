---
name: justfile
description: This skill should be used when the user asks to "add a just recipe", "add a justfile task", "update the justfile", "add a build command", "add a deploy step", or mentions "justfile" or "just" in the context of task running.
user-invocable: false
---

Assist the user in reading, editing, or extending the project's `justfile`.

## Conventions

### Layout

- Default recipe: `just --list --alias-style left --list-heading ''`
- `set quiet` is always present
- `set dotenv-load` / `set dotenv-path` when the project uses `.env` files
- Module-level variables go after settings, before the first group
- Recipes are organized under comment-banner sections (`# group-name` + `# ---...` separator)

### Recipes

- Every public recipe gets `[doc()]` and `[group()]` attributes
- Helpers use `[private]` — no group, hidden from `just --list`
- Destructive recipes use `[confirm()]`
- Frequently used recipes get short aliases (`b`, `r`, `d`, `s`, `t`)
- Multi-line recipes: `#!/usr/bin/env bash` + `set -euo pipefail`; single-command recipes stay inline
- Use recipe dependencies for sequencing; use `trap '...' EXIT` for cleanup

### Parameters

- Environment-targeting recipes take a `tier` parameter
- Tier-specific env: `set -a; source ".env.{{ tier }}"; set +a`
- Terraform workspaces: `workspace select {{ tier }} || workspace new {{ tier }}`
- Check for optional secret tfvars with `if [ -f "...secret.tfvars" ]`

### Naming

- `build-<component>`, `deploy-<component>`, `connect-<service>`, `migrate-<action>`, `seed` / `seed-remote`
- Private wait/serve helpers: `wait-<service>`, `serve-<service>`

## Adding a recipe

1. Place under the matching group section, or create a new banner section.
2. Add `[doc()]`, `[group()]` (or `[private]`), and an alias if frequently used.
3. Use shebang + `set -euo pipefail` for multi-line blocks.
4. Prefer existing variables and recipe dependencies over hardcoding.
