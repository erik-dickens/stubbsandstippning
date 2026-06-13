### Async Svelte and Remote Functions

Async Svelte and remote functions are experimental SvelteKit features that can be toggled in `svelte.config.js`

1. Remote functions are currently true
2. Async Svelte (top level await) is true — required as of SvelteKit 2.56+ because remote function data transport uses `hydratable`

> **Note:** This codebase is in transition. The legacy pattern loads data via page/layout `load` functions and uses form actions with superforms. We're moving toward remote functions for more fine-grained data loading where components themselves declare their data needs. Since remote functions are still experimental, adopt gradually and test thoroughly.

Async Svelte allows `await` in:

- Top-level of `<script>`
- Inside `$derived(...)`: `const post = $derived(await getPost(params.slug))`
- In markup: `{#each await getPosts() as { title, slug }}`, `{(await getPost(slug)).title}`

You MUST NOT use `{#await ...}` blocks. Use `await` expressions instead (inline in markup or with `$derived`).

`await` expressions in markup are fetched in parallel. Using a `await` in top-level script can cause a waterfall. Use `$derived(await ...)` when the query depends on reactive values (params, state) or you need the result as a variable.

**SSR:** Supported. Data is serialized via `hydratable` (no duplicate fetch on client hydration). However for some parts of the app `ssr` is disabled.

**Loading states:** Use `<svelte:boundary>` with a `pending` snippet for initial render. The pending snippet is shown during SSR and until data resolves on the client.

**Errors:** Bubble to the nearest `<svelte:boundary>` with a `failed` snippet.

Remote functions enables type-safe client-server communication. Export from `.remote.ts` files (anywhere in `src`, not in `src/lib/server`).

**Skills:** Use the appropriate skill when implementing:

- `remote-function-query` - reading data (includes `query.batch`)
- `remote-function-form` - form submissions
- `remote-function-command` - server actions
- `remote-function-prerender` - build-time static data

**Validation:** Use Standard Schema (Zod v4) for argument validation.

Source docs for more information (only fetch when really needed).

- [Svelte await expressions](https://svelte.dev/docs/svelte/await-expressions)
- [SvelteKit remote functions](https://svelte.dev/docs/kit/remote-functions)
- [Svelte boundary](https://svelte.dev/docs/svelte/svelte-boundary)

## CI/CD

See `ci/README.md` for CI scripts and server setup.
