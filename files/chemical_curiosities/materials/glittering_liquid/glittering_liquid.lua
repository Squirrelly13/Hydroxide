dofile_once("mods/Hydroxide/lib/Squirreltilities.lua")


local entity_id = GetUpdatedEntityID()

local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed(pos_x + GameGetFrameNum(), pos_y - entity_id)

local angle = math.rad(Random(70,110))
local speed = Random(30,300)

local vel_x = math.cos(angle) * speed
local vel_y = 0 - math.sin(angle) * speed





local fireworks = EntityGetWithTag("rocket")
local fireworkCount = #fireworks

local max_projectiles = ModSettingGet("Hydroxide.MAX_MATERIAL_PROJECTILES") and ModSettingGet("Hydroxide.MAX_MATERIAL_PROJECTILES") * .2 or 12

local firework_options = {
	"mods/Hydroxide/files/chemical_curiosities/materials/glittering_liquid/firework_blue.xml",
	"mods/Hydroxide/files/chemical_curiosities/materials/glittering_liquid/firework_green.xml",
	"mods/Hydroxide/files/chemical_curiosities/materials/glittering_liquid/firework_orange.xml",
	"mods/Hydroxide/files/chemical_curiosities/materials/glittering_liquid/firework_pink.xml",
}

if (fireworkCount >= max_projectiles) then EntityKill(GetUpdatedEntityID()) return end

ShootProjectile(nil, firework_options[Random(1,4)], pos_x, pos_y, vel_x, vel_y)

EntityKill(GetUpdatedEntityID())