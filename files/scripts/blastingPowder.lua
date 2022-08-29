dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local rockets = EntityGetWithTag("rocket")
local rocketCount = #rockets

if (rocketCount <= 60) then
	local angle = math.rad(Random(45,135))
	local length = Random(30,60)
	
	local vel_x = math.cos( angle ) * length
	local vel_y = 0 - math.sin( angle ) * length
	
	shoot_projectile(player, "mods/Hydroxide/files/entities/projectiles/blastRocket.xml", pos_x, pos_y, vel_x, vel_y)
end

EntityKill(GetUpdatedEntityID())