<script lang="ts">
	import type { PageData } from './$types'

	const { data }: { data: PageData } = $props()
</script>

<main>
	<h1>Admin</h1>

	{#if data.currentRound}
		<h2>Omgång: {data.currentRound.name}</h2>

		<div class="columns">
			<section class="not-submitted">
				<h3>Har inte tippat ({data.notSubmitted.length})</h3>
				{#if data.notSubmitted.length === 0}
					<p class="empty">Alla har tippat!</p>
				{:else}
					<ul>
						{#each data.notSubmitted as player (player.id)}
							<li>{player.name}</li>
						{/each}
					</ul>
				{/if}
			</section>

			<section class="submitted">
				<h3>Har tippat ({data.submitted.length})</h3>
				{#if data.submitted.length === 0}
					<p class="empty">Ingen har tippat än.</p>
				{:else}
					<ul>
						{#each data.submitted as player (player.id)}
							<li>{player.name}</li>
						{/each}
					</ul>
				{/if}
			</section>
		</div>
	{:else}
		<p>Ingen aktiv omgång just nu.</p>
	{/if}
</main>

<style>
	main {
		h1 {
			font-family: var(--font-family-heading);
			font-size: var(--font-size-700);
			margin-bottom: var(--space-m);
		}

		h2 {
			font-size: var(--font-size-500);
			font-weight: 600;
			color: var(--color-neutral-700);
			margin-bottom: var(--space-l);
		}
	}

	.columns {
		display: grid;
		grid-template-columns: 1fr 1fr;
		gap: var(--space-l);
	}

	section {
		h3 {
			font-size: var(--font-size-400);
			font-weight: 400;
			margin-bottom: var(--space-s);
			padding-bottom: var(--space-xs);
			border-bottom: 2px solid;
		}

		ul {
			list-style: none;
			display: flex;
			flex-direction: column;
			gap: var(--space-xs);
		}

		li {
			font-size: var(--font-size-400);
		}

		.empty {
			color: var(--color-neutral-400);
			font-size: var(--font-size-300);
		}
	}

	.not-submitted h3 {
		border-color: var(--color-purple-300);
		color: var(--color-purple-700);
	}

	.submitted h3 {
		border-color: var(--color-green-300);
		color: var(--color-green-500);
	}
</style>
