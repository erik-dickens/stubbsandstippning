import { db } from '$lib/server/db'
import { eq, asc } from 'drizzle-orm'
import { predictionItem, round } from '../../../../drizzle/schema.js'
import type { PageServerLoad, Actions } from './$types'
import { fail } from '@sveltejs/kit'

export const load = (async ({ url }) => {
	const rounds = await db.select().from(round).orderBy(asc(round.id))

	const roundIdParam = url.searchParams.get('round')
	const selectedRoundId = roundIdParam ? parseInt(roundIdParam, 10) : null

	let items: (typeof predictionItem.$inferSelect)[] = []
	if (selectedRoundId && !isNaN(selectedRoundId)) {
		items = await db
			.select()
			.from(predictionItem)
			.where(eq(predictionItem.roundId, selectedRoundId))
			.orderBy(asc(predictionItem.createdAt))
	}

	return { rounds, selectedRoundId, items }
}) satisfies PageServerLoad

export const actions = {
	save: async ({ request }) => {
		const data = await request.formData()
		const roundIdStr = data.get('roundId')

		if (!roundIdStr || typeof roundIdStr !== 'string') {
			return fail(400, { error: 'Saknar omgångsnummer' })
		}

		const roundId = parseInt(roundIdStr, 10)
		if (isNaN(roundId)) {
			return fail(400, { error: 'Ogiltigt omgångsnummer' })
		}

		const items = await db
			.select({ id: predictionItem.id, tieBreaker: predictionItem.tieBreaker })
			.from(predictionItem)
			.where(eq(predictionItem.roundId, roundId))

		await Promise.all(
			items.map(async (item) => {
				if (item.tieBreaker) {
					const val = data.get(`item_${item.id}`)
					const num = val !== null && val !== '' ? Number(val) : null
					await db
						.update(predictionItem)
						.set({ correctAnswer: num !== null && !isNaN(num) ? num : null })
						.where(eq(predictionItem.id, item.id))
				} else {
					const selected = data.get(`item_${item.id}`)
					const value = selected !== null && selected !== '' ? String(selected) : null
					await db
						.update(predictionItem)
						.set({ correctAnswer: value })
						.where(eq(predictionItem.id, item.id))
				}
			})
		)

		return { success: true }
	}
} satisfies Actions
