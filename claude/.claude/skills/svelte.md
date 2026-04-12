---
name: svelte
description: SvelteKit and Svelte 5 conventions, code style, and best practices for this repo. Trigger whenever the user is writing, reviewing, or modifying Svelte/TypeScript dashboard code — including components, routes, styles, or any .svelte/.ts files under dashboard/.
---

# Svelte Skill

Project-specific SvelteKit conventions. Follow these whenever writing or reviewing files under `dashboard/`.

## Stack

- **Svelte 5** with runes mode enforced (`compilerOptions.runes: true` in `svelte.config.js`)
- **SvelteKit** with `adapter-static` — this is an SPA (SSR and prerender are disabled)
- **TypeScript** — strict mode, `lang="ts"` on all `<script>` blocks
- **Tailwind CSS v4** — imported via `@tailwindcss/vite` plugin, configured in `layout.css` with `@theme`
- **Vitest** for unit tests, **Playwright** for e2e tests
- **pnpm** as the package manager
- **ESLint** + **Prettier** (with `prettier-plugin-svelte` and `prettier-plugin-tailwindcss`)

## Svelte 5 Runes

This project uses Svelte 5 runes exclusively. **Never use Svelte 4 syntax** (`export let`, `$:`, `on:click`, etc.).

### Props

Use `$props()` to declare component props:

```svelte
<script lang="ts">
  interface Props {
    title: string;
    count?: number;
  }

  let { title, count = 0 }: Props = $props();
</script>
```

### Reactivity

Use `$state` for reactive local state, `$derived` for computed values, and `$effect` for side effects:

```svelte
<script lang="ts">
  let count = $state(0);
  let doubled = $derived(count * 2);

  $effect(() => {
    console.log(`count changed to ${count}`);
  });
</script>
```

### Events

Use callback props instead of `createEventDispatcher`:

```svelte
<script lang="ts">
  interface Props {
    onsubmit: (value: string) => void;
  }

  let { onsubmit }: Props = $props();
</script>

<button onclick={() => onsubmit('hello')}>Submit</button>
```

### Snippets and Children

Use `{@render children()}` for slot content (Svelte 5 replaces `<slot>`):

```svelte
<script lang="ts">
  import type { Snippet } from 'svelte';

  interface Props {
    children: Snippet;
  }

  let { children }: Props = $props();
</script>

<div>
  {@render children()}
</div>
```

### Keyed Each Blocks

Always key `{#each}` blocks when iterating over objects:

```svelte
{#each items as item (item.id)}
  <div>{item.name}</div>
{/each}
```

## SvelteKit Conventions

### SPA Mode

This app is a client-rendered SPA. Every route inherits `ssr = false` and `prerender = false` from `+layout.ts`. Do not add server-side load functions (`+page.server.ts`, `+layout.server.ts`).

### File Organization

```
dashboard/src/
  routes/
    +layout.svelte        # App shell (sidebar, nav)
    +layout.ts            # SPA config: ssr=false, prerender=false
    +page.svelte          # Overview page
    layout.css            # Tailwind import + @theme (brand colors)
    <section>/
      +page.svelte        # Section page
  lib/
    components/           # Reusable UI components
    utils/                # Shared utilities
```

### Routing

Use SvelteKit file-based routing. Each route is a directory under `src/routes/` with a `+page.svelte`. Use `$app/paths` for link resolution:

```svelte
<script lang="ts">
  import { resolve } from '$app/paths';
</script>

<a href={resolve('/licenses')}>Licenses</a>
```

**All `goto()` calls must use `resolve()`** — the ESLint rule `svelte/no-navigation-without-resolve` enforces this:

```svelte
<script lang="ts">
  import { goto } from '$app/navigation';
  import { resolve } from '$app/paths';

  // Correct
  goto(resolve('/login'));

  // Wrong — will fail lint
  goto('/login');
</script>
```

Use `$app/state` (not `$app/stores`) for accessing page state:

```svelte
<script lang="ts">
  import { page } from '$app/state';
</script>

<span>{page.url.pathname}</span>
```

## Styling

### Tailwind v4

Tailwind is configured via the Vite plugin (`@tailwindcss/vite`), not PostCSS. Custom theme tokens are defined in `layout.css` using the `@theme` directive:

```css
@import 'tailwindcss';

@theme {
  --color-brand: #6366f1;
  --color-brand-light: #818cf8;
  --color-brand-dark: #4f46e5;
}
```

Reference these as `text-brand`, `bg-brand-dark`, etc. Prefer Tailwind utility classes over custom CSS. Use the `class` attribute directly — no `class:` directive needed for conditional classes:

```svelte
<div class="rounded-md px-3 py-2 {active ? 'bg-brand/10 text-brand-dark' : 'text-gray-600'}">
```

## Testing

### Unit Tests

Unit tests use Vitest and live alongside the code they test:

```
src/lib/utils/format.ts
src/lib/utils/format.test.ts
```

Tests require assertions (`expect.requireAssertions` is enabled in `vite.config.ts`). Every test must call at least one `expect()`.

Run unit tests: `pnpm test:unit -- --run`

### E2E Tests

E2E tests use Playwright with `testMatch: '**/*.e2e.{ts,js}'`. They build and preview the app before running.

Run e2e tests: `pnpm test:e2e`

## Linting and Formatting

- `pnpm lint` — runs Prettier check + ESLint
- `pnpm format` — auto-formats with Prettier
- `pnpm check` — runs `svelte-check` for type checking

### Before Committing

**Always run lint and fix all errors before committing.** From the `dashboard/` directory:

1. `pnpm format` — auto-format with Prettier
2. `pnpm lint` — run Prettier check + ESLint. **Repeat until clean** — fix any errors and re-run
3. `pnpm check` — run svelte-check for type errors (env var errors from `$env/static/public` are expected if no `.env` file is present locally)

## TypeScript

- Use `lang="ts"` on all `<script>` blocks
- Define prop types with `interface Props` (not inline)
- Use SvelteKit's generated types from `.svelte-kit/` (extended by `tsconfig.json`)
- Use `$lib/` alias for imports from `src/lib/`
