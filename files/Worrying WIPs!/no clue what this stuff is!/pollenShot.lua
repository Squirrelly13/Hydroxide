dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local angle = math.rad(Random(45,135))
local length = Random(60,120)

local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length
	
if (Random(1,7) == 7) then

	shoot_projectile(player, "data/entities/projectiles/deck/pollen.xml", pos_x, pos_y, vel_x, vel_y)

end


EntityKill(GetUpdatedEntityID())