<script lang="ts">
	import type { PageData, ActionData } from './$types'
	import { enhance } from '$app/forms'

	let { data, form }: { data: PageData; form: ActionData } = $props()

	let selectedPlayerId = $state('')
	let selections = $state<Record<number, string>>({})

	function selectOption(itemId: number, option: string) {
		if (selections[itemId] === option) {
			const updated = { ...selections }
			delete updated[itemId]
			selections = updated
		} else {
			selections = { ...selections, [itemId]: option }
		}
	}

	function getOptions(options: unknown): string[] {
		if (Array.isArray(options)) {
			return options.filter((o): o is string => typeof o === 'string')
		}
		return []
	}

	const allAnswered = $derived(
		data.currentRound !== null &&
			data.predictionItems.length > 0 &&
			data.predictionItems.every((item) => selections[item.id] !== undefined)
	)

	const selectedPlayerName = $derived(data.players.find((p) => String(p.id) === String(selectedPlayerId))?.name ?? '')

	const alreadySubmitted = $derived(
		selectedPlayerId !== '' && data.submittedPlayerIds.includes(Number(selectedPlayerId))
	)
</script>

{#if data.currentRound}
	<form method="POST" action="?/submit" use:enhance>
		<p class="round-name"><strong>{data.currentRound.name}</strong></p>
		{#if form?.success}
			<p class="feedback success">Tippningen skickad!</p>
		{:else}
			<div class="player-select">
				<label for="playerId">Tippa som:</label>
				<select id="playerId" name="playerId" bind:value={selectedPlayerId} required>
					<option value="" disabled>Välj...</option>
					{#each data.players as p (p.id)}
						<option value={p.id}>{p.name}</option>
					{/each}
				</select>
			</div>

			{#if alreadySubmitted}
				<p class="already-submitted">{selectedPlayerName} har redan tippat i {data.currentRound.name}</p>
			{:else if selectedPlayerId !== ''}
				<div class="prediction-items">
					{#each data.predictionItems as item, i (item.id)}
						<div class="prediction-item">
							<p class="item-question">
								{#if !item.question}
									Match {i + 1}:
								{:else}
									{item.question}
								{/if}
							</p>
							<div class="options">
								{#each getOptions(item.options) as option (option)}
									<button
										type="button"
										class:selected={selections[item.id] === option}
										onclick={() => selectOption(item.id, option)}
									>
										{option}
									</button>
								{/each}
							</div>
							{#if selections[item.id]}
								<input type="hidden" name="item_{item.id}" value={selections[item.id]} />
							{/if}
						</div>
					{/each}
				</div>

				{#if form?.error}
					<p class="feedback error">{form.error}</p>
				{/if}

				<button type="submit" class="submit-btn" disabled={!allAnswered}>
					Skicka in {selectedPlayerName ? `${selectedPlayerName}s` : ''} tippning!
				</button>
			{/if}
		{/if}
	</form>
{:else}
	<p>Ingen aktiv omgång just nu.</p>
{/if}

<style>
	form {
		text-align: center;
	}
	.round-name {
		margin-bottom: var(--space-l);
		font-size: var(--font-size-500);
		font-weight: 300;
	}

	.already-submitted {
		margin-top: var(--space-l);
		font-size: var(--font-size-500);
		color: var(--color-neutral-700);
	}

	.player-select {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: var(--space-m);
		margin-bottom: var(--space-xl);

		label {
			font-size: var(--font-size-400);
			font-weight: 300;
		}

		select {
			padding: var(--space-xs) var(--space-m);
			font-size: var(--font-size-400);
			border: 1px solid var(--color-neutral-200);
			border-radius: 4px;
			background: white;
			cursor: pointer;
		}
	}

	.prediction-items {
		display: flex;
		flex-direction: column;
		align-items: center;
		gap: var(--space-xl);
		margin-bottom: var(--space-xl);
	}

	.prediction-item {
		display: flex;
		flex-direction: column;
		gap: var(--space-m);
	}

	.item-question {
		font-size: var(--font-size-400);
		font-weight: 500;
	}

	.options {
		display: flex;
		flex-wrap: wrap;
		gap: var(--space-s);

		button {
			padding: var(--space-s) var(--space-l);
			font-size: var(--font-size-400);
			border: 1px solid var(--color-neutral-400);
			background: white;
			cursor: pointer;

			&.selected {
				outline: 1px solid var(--color-green-500);
				background: var(--color-green-300);
				border-color: var(--color-green-500);
				font-weight: 400;
			}
		}
	}

	.feedback {
		margin-bottom: var(--space-m);
		padding: var(--space-s) var(--space-m);
		border-radius: 4px;

		&.error {
			background: #fde8e8;
			color: #c0392b;
		}

		&.success {
			background: var(--color-green-300);
			color: #1a5c36;
		}
	}

	.submit-btn {
		padding: var(--space-m) var(--space-xl);
		font-size: var(--font-size-400);
		font-weight: 500;
		background: var(--color-green-500);
		color: white;
		border: none;
		cursor: pointer;

		&:hover:not(:disabled) {
			background: #3d9a6a;
		}

		&:disabled {
			opacity: 0.4;
			cursor: not-allowed;
		}
	}
</style>
