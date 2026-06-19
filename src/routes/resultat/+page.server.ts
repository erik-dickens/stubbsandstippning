import { db } from '$lib/server/db'
import { player, predictionItem, round, prediction } from '../../../drizzle/schema.js'
import type { PageServerLoad } from './$types'

export const load = (async () => {
	const [players, allPredictions, allPredictionItems, allRounds] = await Promise.all([
		db.select().from(player),
		db.select().from(prediction),
		db.select().from(predictionItem),
		db.select().from(round),
	])

	const itemMap = new Map(allPredictionItems.map((item) => [item.id, item]))
	const roundMap = new Map(allRounds.map((r) => [r.id, r]))

	const scores = players.map((p) => {
		let score = 0
		let tieBreakerDiff: number | null = null
		for (const pred of allPredictions) {
			if (pred.playerId !== p.id) continue
			const item = itemMap.get(pred.predictionItemId)
			if (!item || item.correctAnswer === null) continue
			if (!item.tieBreaker && JSON.stringify(pred.value) === JSON.stringify(item.correctAnswer)) {
				if (item.points) {
					score += item.points
				} else {
					const r = roundMap.get(item.roundId)
					if (r) score += r.points
				}
			}
			if (item.tieBreaker) {
				const predicted = Number(pred.value)
				const correct = Number(item.correctAnswer)
				if (!isNaN(predicted) && !isNaN(correct)) {
					tieBreakerDiff = (tieBreakerDiff ?? 0) + (predicted - correct)
				}
			}
		}
		return { name: p.name, score, tieBreakerDiff }
	})

	scores.sort((a, b) => {
		if (b.score !== a.score) return b.score - a.score
		const aAbs = a.tieBreakerDiff !== null ? Math.abs(a.tieBreakerDiff) : Infinity
		const bAbs = b.tieBreakerDiff !== null ? Math.abs(b.tieBreakerDiff) : Infinity
		if (aAbs !== bAbs) return aAbs - bAbs
		return a.name.localeCompare(b.name)
	})

	const playersSorted = [...players].sort((a, b) => a.name.localeCompare(b.name))
	const itemsSorted = [...allPredictionItems].sort(
		(a, b) => new Date(a.createdAt).getTime() - new Date(b.createdAt).getTime()
	)
	const predictionLookup = Object.fromEntries(
		allPredictions.map((p) => [`${p.playerId}_${p.predictionItemId}`, p.value])
	)

	const now = new Date()
	const lockedRoundIds = new Set(
		allRounds.filter((r) => r.endTime !== null && new Date(r.endTime) > now).map((r) => r.id)
	)

	const hasTieBreaker = allPredictionItems.some((item) => item.tieBreaker)
	const allAnswered = allPredictionItems.length > 0 && allPredictionItems.every((item) => item.correctAnswer !== null)
	const isGameOver = hasTieBreaker && allAnswered

	return {
		scores,
		players: playersSorted,
		items: itemsSorted,
		predictionLookup,
		rounds: allRounds,
		lockedRoundIds: [...lockedRoundIds],
		isGameOver,
	}
}) satisfies PageServerLoad
