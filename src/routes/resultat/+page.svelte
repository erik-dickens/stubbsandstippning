<script lang="ts">
	import type { PageProps } from './$types'

	let { data }: PageProps = $props()

	type View = 'stallning' | 'tippningar'
	let activeView = $state<View>('stallning')

	const roundGroups = $derived.by(() => {
		const roundMap = new Map(data.rounds.map((r) => [r.id, r.name]))
		const groups: { roundId: number; roundName: string; items: typeof data.items }[] = []
		for (const item of data.items) {
			const roundName = roundMap.get(item.roundId) ?? 'Okänd omgång'
			const last = groups[groups.length - 1]
			if (last && last.roundId === item.roundId) {
				last.items.push(item)
			} else {
				groups.push({ roundId: item.roundId, roundName, items: [item] })
			}
		}
		return groups
	})

	const lockedRoundIds = $derived(new Set(data.lockedRoundIds))

	const roundProgress = $derived.by(() => {
		const roundMap = new Map(data.rounds.map((r) => [r.id, r.name]))
		const map = new Map<number, { name: string; total: number; answered: number }>()
		for (const item of data.items) {
			const name = roundMap.get(item.roundId) ?? 'Okänd omgång'
			const entry = map.get(item.roundId) ?? { name, total: 0, answered: 0 }
			entry.total++
			if (item.correctAnswer !== null && item.correctAnswer !== undefined) entry.answered++
			map.set(item.roundId, entry)
		}
		return [...map.values()]
	})

	function getOptions(options: unknown): string[] {
		if (Array.isArray(options)) return options.filter((o): o is string => typeof o === 'string')
		return []
	}

	function getDisplayText(value: unknown): string {
		if (typeof value === 'string') return value.slice(0, 3)
		if (typeof value === 'number') return String(value).slice(0, 3)
		return '?'
	}
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
	<ul class="round-progress">
		<li><strong>Rättade matcher:</strong></li>
		{#each roundProgress as r (r.name)}
			<li>{r.name} ({r.answered}/{r.total})</li>
		{/each}
	</ul>
{:else}
	{#each roundGroups as group (group.roundId)}
		{#if group.items.length > 0}
			<div class="round-section">
				<h2 class="round-title">{group.roundName}</h2>
				<div class="matrix-scroll">
					<table class="matrix">
						<thead>
							<tr>
								<th class="player-col"></th>
								{#each group.items as item (item.id)}
									<th>
										{#each getOptions(item.options) as option}
											{option.slice(0, 3)}<br />
										{/each}
									</th>
								{/each}
							</tr>
						</thead>
						<tbody>
							{#each data.players as player (player.id)}
								<tr>
									<td class="player-col">{player.name}</td>
									{#each group.items as item (item.id)}
										{@const pred = data.predictionLookup[`${player.id}_${item.id}`]}
										{@const hasAnswer = item.correctAnswer !== null && item.correctAnswer !== undefined}
										{@const locked = lockedRoundIds.has(item.roundId)}
										{@const correct =
											!locked &&
											pred !== undefined &&
											hasAnswer &&
											JSON.stringify(pred) === JSON.stringify(item.correctAnswer)}
										{@const wrong = !locked && pred !== undefined && hasAnswer && !correct}
										<td class:correct class:wrong>
											{pred !== undefined ? (locked ? 'x' : getDisplayText(pred)) : ''}
										</td>
									{/each}
								</tr>
							{/each}
						</tbody>
					</table>
				</div>
			</div>
		{/if}
	{/each}
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

	.round-progress {
		list-style: none;
		padding: var(--space-m) var(--space-l);
		display: flex;
		flex-direction: column;
		gap: var(--space-xs);
		color: var(--color-neutral-600);
		font-size: var(--font-size-300);
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

	.matrix-scroll {
		overflow-x: auto;
		padding: var(--space-l);
	}

	.matrix {
		border-collapse: collapse;
		font-size: var(--font-size-300);
	}

	.matrix th,
	.matrix td {
		padding: var(--space-xs) var(--space-s);
		border: 1px solid var(--color-neutral-200);
		text-align: center;
		vertical-align: middle;
	}

	.matrix thead th {
		background: var(--color-neutral-200);
		font-weight: 600;
		line-height: 1.3;
		white-space: normal;
		min-width: 3.5ch;
	}

	.player-col {
		text-align: left;
		white-space: nowrap;
		position: sticky;
		left: 0;
		background: var(--color-neutral-100);
		z-index: 1;
	}

	.matrix thead .player-col {
		background: var(--color-neutral-200);
	}

	.round-section {
		padding-bottom: var(--space-l);
	}

	.round-title {
		padding: 0 var(--space-l) var(--space-s);
		font-size: var(--font-size-400);
	}

	.correct {
		background: var(--color-green-300);
	}

	.wrong {
		background: #f5a5a5;
	}
</style>
