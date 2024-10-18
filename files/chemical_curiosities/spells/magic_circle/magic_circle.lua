dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/lib/squirreltilities.lua")


EntityAddComponent2( GetUpdatedEntityID(), "AudioComponent", {
	file="data/audio/Desktop/projectiles.bank",
	event_root="player_projectiles/meteor",
	set_latest_event_position=true
});

GamePrint("wooo, magiic shit wooooo")

