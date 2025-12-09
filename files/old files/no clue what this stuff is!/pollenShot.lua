dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
local owner = EntityGetRootEntity(entity_id)

local pos_x, pos_y = EntityGetTransform( owner )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - owner)

local angle = math.rad(Random(45,135))
local length = Random(60,120)

local vel_x = math.cos(angle) * length
local vel_y = 0 - math.sin(angle) * length

if (Random(1,7) == 7) then

	ShootProjectile(player, "data/entities/projectiles/deck/pollen.xml", pos_x, pos_y, vel_x, vel_y)

end


EntityKill(GetUpdatedEntityID())