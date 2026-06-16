import { db } from '$lib/server/db'
import { eq, asc, inArray } from 'drizzle-orm'
import { player, predictionItem, round, prediction } from '../../drizzle/schema.js'
import type { PageServerLoad, Actions } from './$types'
import { fail } from '@sveltejs/kit'

export const load = (async () => {
	const players = await db.select().from(player).orderBy(asc(player.name))
	const currentRound = await db.select().from(round).where(eq(round.current, true))
	if (currentRound.length > 0) {
		const predictionItems = await db
			.select()
			.from(predictionItem)
			.where(eq(predictionItem.roundId, currentRound[0].id))
			.orderBy(asc(predictionItem.createdAt))
		const predictionItemIds = predictionItems.map((item) => item.id)
		const submittedPlayerIds =
			predictionItemIds.length > 0
				? (
						await db
							.selectDistinct({ playerId: prediction.playerId })
							.from(prediction)
							.where(inArray(prediction.predictionItemId, predictionItemIds))
					).map((r) => r.playerId)
				: []

		const isClosed = currentRound[0].endTime !== null && new Date(currentRound[0].endTime) < new Date()
		return { currentRound: currentRound[0], players, predictionItems, submittedPlayerIds, isClosed }
	}
	return { currentRound: null, players, predictionItems: [], submittedPlayerIds: [] as number[], isClosed: false }
}) satisfies PageServerLoad

export const actions = {
	submit: async ({ request }) => {
		const data = await request.formData()
		const playerId = data.get('playerId')

		if (!playerId || typeof playerId !== 'string') {
			return fail(400, { error: 'Välj en spelare' })
		}

		const currentRound = await db.select().from(round).where(eq(round.current, true))
		if (currentRound.length === 0) {
			return fail(400, { error: 'Ingen aktiv omgång' })
		}
		if (currentRound[0].endTime !== null && new Date(currentRound[0].endTime) < new Date()) {
			return fail(400, { error: `Tippningen är stängd för ${currentRound[0].name}` })
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
	},
} satisfies Actions
