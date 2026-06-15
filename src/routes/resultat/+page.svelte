<script lang="ts">
	import type { PageProps } from './$types'

	let { data }: PageProps = $props()
</script>

<ol class="scoreboard">
	{#each data.scores as entry, i (entry.name)}
		<li>
			<span class="rank">{i + 1}.</span>
			<span class="name">{entry.name}</span>
			<span class="dots" aria-hidden="true"></span>
			<span class="score">{entry.score}</span>
		</li>
	{/each}
</ol>

<style>
	.scoreboard {
		list-style: none;
		padding: var(--space-l);
		display: flex;
		flex-direction: column;
		gap: var(--space-s);
		max-width: 400px;
	}

	.scoreboard li {
		display: flex;
		align-items: baseline;
		gap: var(--space-s);
		font-size: var(--font-size-500);
	}

	.rank {
		min-width: 2ch;
		color: var(--color-neutral-400);
	}

	.dots {
		flex: 1;
		border-bottom: 2px dotted var(--color-neutral-400);
		margin-bottom: 0.2em;
	}

	.score {
		font-weight: bold;
		font-variant-numeric: tabular-nums;
	}
</style>
