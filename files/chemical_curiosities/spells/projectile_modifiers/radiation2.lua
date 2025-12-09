dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")

local entity_id = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)
local angle = math.rad(Random(1,360))
local speed = Random(25,75)
speed = 5 * (speed ^ 0.8)

local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed

if (#EntityGetWithTag("radiation") <= 200) then
	ShootProjectile(entity_id, "mods/Hydroxide/files/chemical_curiosities/materials/uranium/radiation_glow.xml", pos_x, pos_y, vel_x, vel_y)
end