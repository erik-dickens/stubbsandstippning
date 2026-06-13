import { db } from '$lib/server/db'
import { eq } from 'drizzle-orm'
import { player, predictionItem, round } from '../../drizzle/schema.js'
import { DATABASE_URL } from '$env/static/private'
import type { PageServerLoad } from './$types'

export const load = (async () => {
	console.log('database url: ', DATABASE_URL)
	const players = await db.select().from(player)
	const currentRound = await db.select().from(round).where(eq(round.current, true))
	if (currentRound.length > 0) {
		const preditionItems = await db.select().from(predictionItem).where(eq(predictionItem.roundId, currentRound[0].id))
		return { currentRound: currentRound[0], players, preditionItems }
	}
	return { currentRound: null, players, preditionItems: [] }
}) satisfies PageServerLoad
