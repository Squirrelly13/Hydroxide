local oldmax = spawnlists.potion_spawnlist.rnd_max
local oldmax2 = spawnlists.potion_spawnlist_liquidcave.rnd_max

spawnlists.potion_spawnlist.rnd_max = spawnlists.potion_spawnlist.rnd_max + 2
spawnlists.potion_spawnlist_liquidcave.rnd_max = spawnlists.potion_spawnlist_liquidcave.rnd_max + 2

table.insert(spawnlists.potion_spawnlist.spawns, { 
	value_min  = oldmax + 1,
	value_max  = oldmax + 2,
	load_entity="mods/Hydroxide/files/Chemical Curiosities/items/runestone_crystal/runestone_crystal.xml",
	offset_y   = -2,
});



table.insert(spawnlists.potion_spawnlist_liquidcave.spawns, { 
	value_min  = oldmax2 + 1,
	value_max  = oldmax2 + 2,
	load_entity="mods/Hydroxide/files/Chemical Curiosities/items/runestone_crystal/runestone_crystal.xml",
	offset_y   = -2,
});