import { db } from '$lib/server/db'
import { eq } from 'drizzle-orm'
import { player, predictionItem, round, prediction } from '../../drizzle/schema.js'
import type { PageServerLoad, Actions } from './$types'
import { fail } from '@sveltejs/kit'

export const load = (async () => {
	const players = await db.select().from(player)
	const currentRound = await db.select().from(round).where(eq(round.current, true))
	if (currentRound.length > 0) {
		const predictionItems = await db.select().from(predictionItem).where(eq(predictionItem.roundId, currentRound[0].id))
		return { currentRound: currentRound[0], players, predictionItems }
	}
	return { currentRound: null, players, predictionItems: [] }
}) satisfies PageServerLoad

export const actions = {
	submit: async ({ request }) => {
		const data = await request.formData()
		const playerId = data.get('playerId')

		if (!playerId || typeof playerId !== 'string') {
			return fail(400, { error: 'Välj en spelare' })
		}

		const values: { playerId: number; predictionItemId: number; value: string }[] = []
		for (const [key, value] of data.entries()) {
			if (key.startsWith('item_')) {
				const predictionItemId = parseInt(key.slice(5))
				if (!isNaN(predictionItemId)) {
					values.push({ playerId: Number(playerId), predictionItemId, value: String(value) })
				}
			}
		}

		if (values.length === 0) {
			return fail(400, { error: 'Välj minst ett alternativ' })
		}

		await db.insert(prediction).values(values)

		return { success: true }
	}
} satisfies Actions

