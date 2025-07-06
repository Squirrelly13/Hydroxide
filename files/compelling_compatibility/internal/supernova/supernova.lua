dofile_once("data/scripts/lib/utilities.lua")


local entity_id    = GetUpdatedEntityID()
local x, y, rot = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), x + y + entity_id )

print("SUMMONING SUPERNOVA AT " .. x .. " " .. y .. "!!!!!!!!!!!!!!!!!")


EntityLoad( "data/entities/particles/supernova.xml", x, y )
GameScreenshake( 100, x, y )
GamePlaySound( "data/audio/Desktop/misc.bank", "misc/sun/supernova", x, y )

local players = EntityGetWithTag( "player_unit" )
local mortals = EntityGetWithTag( "mortal" )

for i,v in ipairs( players ) do
	local eid = EntityLoad( "data/entities/misc/eradicate.xml", x, y )
	EntityAddChild( v, eid )

	local px,py = EntityGetTransform( v )
	EntityLoad( "data/entities/particles/supernova.xml", px, py )
end

for i,v in ipairs( mortals ) do
	local test = EntityGetFirstComponent( v, "DamageModelComponent" )

	if ( test ~= nil ) then
		EntityInflictDamage( v, 50000000, "DAMAGE_CURSE", "$damage_supernova", "DISINTEGRATED", 0, 0, entity_id )
	end
end

EntityKill( entity_id )