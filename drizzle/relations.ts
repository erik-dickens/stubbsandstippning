import { relations } from "drizzle-orm/relations";
import { player, prediction, predictionItem, championship, round } from "./schema";

export const predictionRelations = relations(prediction, ({one}) => ({
	player: one(player, {
		fields: [prediction.playerId],
		references: [player.id]
	}),
	predictionItem: one(predictionItem, {
		fields: [prediction.predictionItemId],
		references: [predictionItem.id]
	}),
}));

export const playerRelations = relations(player, ({many}) => ({
	predictions: many(prediction),
}));

export const predictionItemRelations = relations(predictionItem, ({one, many}) => ({
	predictions: many(prediction),
	round: one(round, {
		fields: [predictionItem.roundId],
		references: [round.id]
	}),
}));

export const roundRelations = relations(round, ({one, many}) => ({
	championship: one(championship, {
		fields: [round.championshipId],
		references: [championship.id]
	}),
	predictionItems: many(predictionItem),
}));

export const championshipRelations = relations(championship, ({many}) => ({
	rounds: many(round),
}));