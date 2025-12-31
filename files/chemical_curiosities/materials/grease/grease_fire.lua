dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity(entity_id)
local pos_x, pos_y = EntityGetTransform(entity_id)

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)

local angle = math.rad(Random(45,135))
local speed = Random(150,400)

local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

if(Random(1,10) == 1) then
	ShootProjectile(entity_id, "mods/Hydroxide/files/chemical_curiosities/materials/grease/grease_bubble.xml", pos_x, pos_y, vel_x, vel_y)
end

EntityKill(entity_id)