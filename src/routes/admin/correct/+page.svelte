<script lang="ts">
	import { goto } from '$app/navigation'
	import { resolve } from '$app/paths'
	import { enhance } from '$app/forms'
	import type { PageData, ActionData } from './$types'

	const { data, form }: { data: PageData; form: ActionData } = $props()

	function handleRoundChange(e: Event) {
		const select = e.currentTarget as HTMLSelectElement
		const val = select.value
		if (val) {
			goto(`${resolve('/admin/correct')}?round=${val}`)
		} else {
			goto(resolve('/admin/correct'))
		}
	}

	function getOptions(options: unknown): string[] {
		if (Array.isArray(options)) return options.filter((o): o is string => typeof o === 'string')
		return []
	}

	function getCorrectAnswerString(correctAnswer: unknown): string | null {
		if (typeof correctAnswer === 'string') return correctAnswer
		return null
	}

	function getCorrectAnswerNumber(correctAnswer: unknown): string {
		if (correctAnswer !== null && correctAnswer !== undefined) return String(correctAnswer)
		return ''
	}
</script>

<main>
	<h1>Rätta svar</h1>

	<div class="round-select">
		<label for="round-dropdown">Omgång</label>
		<select id="round-dropdown" onchange={handleRoundChange}>
			<option value="">Välj omgång...</option>
			{#each data.rounds as r (r.id)}
				<option value={r.id} selected={r.id === data.selectedRoundId}>{r.name}</option>
			{/each}
		</select>
	</div>

	{#if data.selectedRoundId && data.items.length === 0}
		<p class="empty">Inga matcher ännu i den här omgången.</p>
	{/if}

	{#if data.items.length > 0}
		<form method="POST" action="?/save" use:enhance>
			<input type="hidden" name="roundId" value={data.selectedRoundId} />

			<div class="items">
				{#each data.items as item, i (item.id)}
					<div class="item">
						<p class="question">
							{item.question ?? `Match ${i + 1}`}
							{#if item.tieBreaker}
								<span class="tiebreaker-badge">Tiebreaker</span>
							{/if}
						</p>

						{#if item.tieBreaker}
							<input
								class="tiebreaker-input"
								type="number"
								name="item_{item.id}"
								min="0"
								max="9999"
								value={getCorrectAnswerNumber(item.correctAnswer)}
								placeholder="Rätt svar..."
							/>
						{:else}
							<div class="options">
								<label class="option option-clear">
									<input
										type="radio"
										name="item_{item.id}"
										value=""
										checked={getCorrectAnswerString(item.correctAnswer) === null}
									/>
									–
								</label>
								{#each getOptions(item.options) as option}
									<label class="option">
										<input
											type="radio"
											name="item_{item.id}"
											value={option}
											checked={getCorrectAnswerString(item.correctAnswer) === option}
										/>
										{option}
									</label>
								{/each}
								{#if getOptions(item.options).length === 0}
									<p class="empty">Inga alternativ.</p>
								{/if}
							</div>
						{/if}
					</div>
				{/each}
			</div>

			{#if form?.success}
				<p class="feedback success">Sparat!</p>
			{/if}
			{#if form?.error}
				<p class="feedback error">{form.error}</p>
			{/if}

			<button type="submit" class="save-btn">Spara</button>
		</form>
	{/if}
</main>

<style>
	main {
		padding: var(--space-m);
		max-width: 640px;
		width: 100%;

		h1 {
			font-family: var(--font-family-heading);
			font-size: var(--font-size-700);
			margin-bottom: var(--space-m);
		}
	}

	.round-select {
		display: flex;
		flex-direction: column;
		gap: var(--space-xs);
		margin-bottom: var(--space-l);

		label {
			font-size: var(--font-size-300);
			font-weight: 600;
			color: var(--color-neutral-700);
		}

		select {
			font-family: var(--font-family-body);
			font-size: var(--font-size-400);
			padding: var(--space-xs) var(--space-s);
			border: 1px solid var(--color-neutral-400);
			border-radius: var(--border-radius);
			background: white;
			cursor: pointer;
		}
	}

	.items {
		display: flex;
		flex-direction: column;
		gap: var(--space-m);
		margin-bottom: var(--space-l);
	}

	.item {
		background: white;
		border: 1px solid var(--color-neutral-200);
		border-radius: var(--border-radius);
		padding: var(--space-m);

		.question {
			font-size: var(--font-size-400);
			font-weight: 600;
			margin-bottom: var(--space-s);
			display: flex;
			align-items: center;
			gap: var(--space-s);
		}
	}

	.tiebreaker-badge {
		font-size: var(--font-size-300);
		font-weight: 400;
		color: var(--color-purple-700);
		background: var(--color-purple-300);
		padding: 2px var(--space-xs);
		border-radius: 4px;
	}

	.options {
		display: flex;
		flex-direction: column;
		gap: var(--space-xs);
	}

	.option {
		display: flex;
		align-items: center;
		gap: var(--space-s);
		font-size: var(--font-size-400);
		cursor: pointer;

		input[type='radio'] {
			width: 1.1em;
			height: 1.1em;
			accent-color: var(--color-purple-500);
			cursor: pointer;
		}
	}

	.tiebreaker-input {
		font-family: var(--font-family-body);
		font-size: var(--font-size-400);
		padding: var(--space-xs) var(--space-s);
		border: 1px solid var(--color-neutral-400);
		border-radius: var(--border-radius);
		width: 8rem;
	}

	.save-btn {
		padding: var(--space-s) var(--space-l);
		background: var(--color-purple-500);
		color: white;
		border: none;
		cursor: pointer;

		&:hover {
			background: var(--color-purple-700);
		}
	}

	.feedback {
		margin-bottom: var(--space-s);
		font-size: var(--font-size-400);

		&.success {
			color: var(--color-green-500);
		}

		&.error {
			color: #c0392b;
		}
	}

	.empty {
		color: var(--color-neutral-400);
		font-size: var(--font-size-300);
	}
</style>
