import { db } from '$lib/server/db';
import { player } from '../../drizzle/schema.js';
import { DATABASE_URL } from '$env/static/private';
import type { PageServerLoad } from './$types';

export const load = (async () => {
	console.log('database url: ', DATABASE_URL);
	const players = await db.select().from(player);
	console.log(players);
	return { players };
}) satisfies PageServerLoad;
