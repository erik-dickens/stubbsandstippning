import { pgTable, foreignKey, integer, timestamp, json, text, smallint, boolean, unique } from "drizzle-orm/pg-core"
import { sql } from "drizzle-orm"



export const prediction = pgTable("prediction", {
	id: integer().primaryKey().generatedByDefaultAsIdentity({ name: "prediction_id_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	createdAt: timestamp("created_at", { withTimezone: true, mode: 'string' }).defaultNow().notNull(),
	playerId: integer("player_id").notNull(),
	predictionItemId: integer("prediction_item_id").notNull(),
	value: json().notNull(),
}, (table) => [
	foreignKey({
			columns: [table.playerId],
			foreignColumns: [player.id],
			name: "prediction_player_id_fkey"
		}).onDelete("cascade"),
	foreignKey({
			columns: [table.predictionItemId],
			foreignColumns: [predictionItem.id],
			name: "prediction_prediction_item_id_fkey"
		}).onDelete("cascade"),
]);

export const round = pgTable("round", {
	id: integer().primaryKey().generatedByDefaultAsIdentity({ name: "round_id_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	createdAt: timestamp("created_at", { withTimezone: true, mode: 'string' }).defaultNow().notNull(),
	championshipId: integer("championship_id").notNull(),
	name: text().notNull(),
	points: smallint().notNull(),
	endTime: timestamp("end_time", { withTimezone: true, mode: 'string' }),
	current: boolean().default(false).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.championshipId],
			foreignColumns: [championship.id],
			name: "round_championship_id_fkey"
		}).onDelete("cascade"),
]);

export const predictionItem = pgTable("prediction_item", {
	id: integer().primaryKey().generatedByDefaultAsIdentity({ name: "prediction_item_id_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	createdAt: timestamp("created_at", { withTimezone: true, mode: 'string' }).defaultNow().notNull(),
	roundId: integer("round_id").notNull(),
	question: text().notNull(),
	options: json(),
	correctAnswer: json("correct_answer"),
	tieBreaker: boolean("tie_breaker").default(false).notNull(),
}, (table) => [
	foreignKey({
			columns: [table.roundId],
			foreignColumns: [round.id],
			name: "prediction_item_round_id_fkey"
		}).onDelete("cascade"),
]);

export const championship = pgTable("championship", {
	id: integer().primaryKey().generatedByDefaultAsIdentity({ name: "championship_id_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	name: text().notNull(),
	createdAt: timestamp("created_at", { withTimezone: true, mode: 'string' }).defaultNow().notNull(),
}, (table) => [
	unique("championship_name_key").on(table.name),
]);

export const player = pgTable("player", {
	id: integer().primaryKey().generatedByDefaultAsIdentity({ name: "player_id_seq", startWith: 1, increment: 1, minValue: 1, maxValue: 2147483647, cache: 1 }),
	createdAt: timestamp("created_at", { withTimezone: true, mode: 'string' }).defaultNow().notNull(),
	name: text().notNull(),
});
