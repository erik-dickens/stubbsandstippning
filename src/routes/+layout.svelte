<script lang="ts">
	import favicon from '$lib/assets/favicon.svg'
	import banner from '$lib/assets/banner.png'
	import { page } from '$app/state'
	import { onNavigate } from '$app/navigation'
	import '../global.css'
	import { resolve } from '$app/paths'

	let { children } = $props()

	onNavigate((navigation) => {
		if (!document.startViewTransition) return

		return new Promise((done) => {
			document.startViewTransition(async () => {
				done()
				await navigation.complete
			})
		})
	})
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<div class="app">
	<header class="banner">
		<img src={banner} alt="Stubbsandstippning" />
	</header>

	<nav class="nav">
		<a href={resolve('/')} class:active={page.url.pathname === '/'} style="view-transition-name: nav-tippa"
			>{page.url.pathname !== '/' ? '<' : ''}Tippa!</a
		>
		<a
			href={resolve('/resultat')}
			class:active={page.url.pathname === '/resultat'}
			style="view-transition-name: nav-resultat">Resultat {page.url.pathname !== '/resultat' ? '>' : ''}</a
		>
	</nav>

	<main class="content">
		{@render children()}
	</main>
</div>

<style>
	.app {
		max-width: min(600px, 100%);
		margin: 0 auto;
	}

	.banner {
		width: 100%;

		img {
			display: block;
			width: 100%;
			height: auto;
		}
	}

	.nav {
		font-family: var(--font-family-heading);
		display: grid;
		grid-template-columns: 1fr 1fr 1fr;
		align-items: baseline;
		padding: var(--space-m) var(--space-l);
		border-bottom: 1px solid var(--color-neutral-200);

		a {
			text-decoration: none;
			color: var(--color-neutral-700);
			font-size: var(--font-size-800);

			&:first-child {
				grid-column: 1;
				justify-self: start;
			}

			&:first-child.active {
				grid-column: 2;
				justify-self: center;
			}

			&:last-child {
				grid-column: 3;
				justify-self: end;
			}

			&:last-child.active {
				grid-column: 2;
				justify-self: center;
			}

			&.active {
				font-size: var(--font-size-600);
				font-weight: bold;
				color: var(--color-neutral-900);
			}
		}
	}

	.content {
		padding: var(--space-l);
	}

	:global(::view-transition-group(nav-tippa)),
	:global(::view-transition-group(nav-resultat)) {
		animation-duration: 350ms;
		animation-timing-function: ease-in-out;
	}
</style>
