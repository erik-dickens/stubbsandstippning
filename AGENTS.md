# Guidelines

## Project Overview

This repo contains a betting/prediction SvelteKit app.

The repo uses `pnpm` package manager (current version 10).

### Database

The project uses a PostgresQL database hosted at supabase.
It uses drizzle ORM as a data access layer.

Schema is defines in ./drizzle/schema.ts

You SHOULD remind and warn the user that changes to the database schema can require creation of migration files (`./drizzle/*.sql`). You should not start creating such migration files without explicit approval, but you SHOULD be aware of this and prompt the user when necessary.

## Svelte and SvelteKit

The codebase contains modern Svelte 5 (runes) code.

- You MUST use Svelte 5 (runes) syntax when writing new code. DO NOT use Svelte 4 syntax.
- You SHOULD avoid too large components. If a component grows too large, consider breaking it down into smaller, more focused components. Ask the user before doing so.

### Using resolve for type-safe links

Use `resolve` when creating internal links or when using goto. This provides type safety.

```ts
import { resolve } from '$app/paths';

// using a pathname
const resolved = resolve(`/blog/hello-world`);

// using a route ID plus parameters
const resolved = resolve('/blog/[slug]', {
	slug: 'hello-world'
});
```

You SHOULD use resolve for internal links (`<a href`) in general.
You MUST NOT use resolve for external links or static files.

### `$app/stores` deprecated in favour of `$app/state`

Use `$app/state` like the following. Note that this is not longer a store, but a reactive object.

You MUST use `$app/state` instead of `$app/stores` as the latter is deprecated.

```svelte
<script lang="ts">
	import { page } from '$app/state';
</script>

<p>Currently at {page.url.pathname}</p>
```

## CSS

We use global styles (`src/global.css`) and component styles.

You SHOULD be aware of global styles in order and try to utilize global styles before writing component styles.

### CSS Variables

Looks like this:
`--font-size-300` etc
`--color-purple-300`
`--space-s`, `--space-m`
No font weight properties.

Note that `--font-size-300` and `--space-s` are themselves responsive (using `clamp`) in order to decrease the need for media queries.

You SHOULD use modern CSS whenever possible (as long as baseline support).
You SHOULD lookup existing css-variables when styling and use them when possible.
You SHOULD prefer using CSS nesting for better readability and maintainability.
You SHOULD have a bias to use as little CSS as possible. Avoid adding noise and unnecessary or uncertain styles. Things can be iterated on later.
You SHOULD avoid using excessive media queries for font-size and spacing. Use the existing responsive CSS variables instead and only add media queries when a major shift is needed.

## Icons

You SHOULD use `@iconify/svelte` whenever icons are needed, like so: `import Icon from '@iconify/svelte'`

## General coding guidelines

- You SHOULD only add comments when the code is not self-explanatory.
- You SHOULD not use js/ts-classes. Use functions and objects instead.
- You SHOULD not use type assertions. If necessary consider creating a type guard function.
- You SHOULD prefer const over let for all variables that are not reassinged.

## Other guidelines

- You SHOULD use `pnpm run check --threshold error` (note: no extra double dash `--` when using `pnpm`) to check for type errors. Your own LSP may contain stale feedback, so you SHOULD run the check command manually to verify.
- When doing large amounts of work in batches, you SHOULD run checks between batches in order to catch issues early.
- You MUST NOT use git without explicit approval unless read-only operations. Eg `git diff` is OK while `git stash` is not.
- You MUST NOT attempt to start the web server yourself.
- You SHOULD assume that the cwd is the project root. You SHOULD NOT type out the full absolute path when running bash tool etc unless necessary for some reason. Use relative paths, like `src/lib/somefile`.
