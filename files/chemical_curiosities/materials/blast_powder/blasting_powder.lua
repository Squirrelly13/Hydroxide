dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


local entity_id = GetUpdatedEntityID()
local owner = EntityGetRootEntity(entity_id)

local pos_x, pos_y = EntityGetTransform(owner)

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - owner)

local rockets = EntityGetWithTag("rocket") --NOTE should replace the tag check with something else.
local rocketCount = #rockets

if (rocketCount <= ModSettingGet("Hydroxide.MAX_MATERIAL_PROJECTILES") or 60) then
	local angle = math.rad(Random(45,135))
	local speed = Random(30,60)

	local vel_x = math.cos(angle) * speed
	local vel_y = 0 - math.sin(angle) * speed

	ShootProjectile(nil, "mods/Hydroxide/files/chemical_curiosities/materials/blast_powder/blast_rocket.xml", pos_x, pos_y, vel_x, vel_y)
end

EntityKill(entity_id)