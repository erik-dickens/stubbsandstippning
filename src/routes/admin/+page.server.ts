import { db } from '$lib/server/db'
import { eq, asc, inArray } from 'drizzle-orm'
import { player, predictionItem, round, prediction } from '../../../drizzle/schema.js'
import type { PageServerLoad } from './$types'

export const load = (async () => {
	const [players, currentRound] = await Promise.all([
		db.select().from(player).orderBy(asc(player.name)),
		db.select().from(round).where(eq(round.current, true)),
	])

	if (currentRound.length === 0) {
		return { currentRound: null, submitted: [], notSubmitted: players }
	}

	const predictionItems = await db
		.select({ id: predictionItem.id })
		.from(predictionItem)
		.where(eq(predictionItem.roundId, currentRound[0].id))

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

	const submittedSet = new Set(submittedPlayerIds)
	const submitted = players.filter((p) => submittedSet.has(p.id))
	const notSubmitted = players.filter((p) => !submittedSet.has(p.id))

	return { currentRound: currentRound[0], submitted, notSubmitted }
}) satisfies PageServerLoad
