<script lang="ts">
	import type { PageProps } from './$types'

	let { data }: PageProps = $props()

	type View = 'stallning' | 'tippningar'
	let activeView = $state<View>('stallning')
</script>

<div class="controls">
	<div class="segmented-control" role="group" aria-label="Välj vy">
		<button class:active={activeView === 'stallning'} onclick={() => (activeView = 'stallning')}> Ställning </button>
		<button class:active={activeView === 'tippningar'} onclick={() => (activeView = 'tippningar')}> Tippningar </button>
	</div>
</div>

{#if activeView === 'stallning'}
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
{:else}
	<p class="under-construction">Under construction</p>
{/if}

<style>
	.controls {
		display: flex;
		justify-content: center;
		padding-bottom: var(--space-m);
	}

	.segmented-control {
		display: inline-flex;
		background: var(--color-neutral-200);
		border-radius: var(--border-radius);
		padding: 3px;
		gap: 2px;

		button {
			border: none;
			background: transparent;
			padding: var(--space-xs) var(--space-m);
			border-radius: calc(var(--border-radius) - 2px);
			cursor: pointer;
			color: var(--color-neutral-700);
			transition:
				background 0.15s,
				color 0.15s;

			&.active {
				background: white;
				color: var(--color-neutral-900);
				font-weight: 600;
				box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
			}
		}
	}

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

	.under-construction {
		padding: var(--space-l);
		color: var(--color-neutral-400);
	}
</style>
