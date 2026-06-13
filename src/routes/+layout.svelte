<script lang="ts">
	import favicon from '$lib/assets/favicon.svg'
	import banner from '$lib/assets/banner.png'
	import { page } from '$app/state'
	import '../global.css'

	let { children } = $props()
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<div class="app">
	<header class="banner">
		<img src={banner} alt="Stubbsandstippning" />
	</header>

	<nav class="nav">
		<a href="/" class:active={page.url.pathname === '/'}>Tippa!</a>
		<a href="/resultat">Resultat &gt;</a>
	</nav>

	<main class="content">
		{@render children()}
	</main>
</div>

<style>
	.app {
		max-width: 600px;
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
		display: flex;
		align-items: baseline;
		gap: var(--space-l);
		padding: var(--space-m) var(--space-l);
		border-bottom: 1px solid var(--color-neutral-200);

		a {
			text-decoration: none;
			color: var(--color-neutral-700);
			font-size: var(--font-size-500);

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
</style>
