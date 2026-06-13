<script lang="ts">
	import type { PageData } from './$types';

	let { data }: { data: PageData } = $props();
</script>

<h1>Stubbsandstippning</h1>
<ul>
	{#each data.players as player}
		<li>{player.name}</li>
	{/each}
</ul>
