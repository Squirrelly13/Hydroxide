dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform(entity_id)

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)

if #EntityGetWithTag("rocket") <= (ModSettingGet("Hydroxide.MAX_MATERIAL_PROJECTILES") or 60) then
	local angle = math.rad(Random(45,135))
	local speed = Random(30,60)

	local vel_x = math.cos(angle) * speed
	local vel_y = 0 - math.sin(angle) * speed

	ShootProjectile(nil, "mods/Hydroxide/files/chemical_curiosities/materials/blast_powder/blast_rocket.xml", pos_x, pos_y, vel_x, vel_y)
end

EntityKill(entity_id)