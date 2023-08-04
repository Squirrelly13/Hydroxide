dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local angle = math.rad(Random(70,110))
local length = Random(30,300)

local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length
	




local fireworks = EntityGetWithTag("rocket")
local fireworkCount = #fireworks


if (fireworkCount <= 12) then
	local value = Random(1,4)
	if (value == 1) then
		shoot_projectile(player, "mods/Hydroxide/files/Chemical Curiosities/materials/glitteringLiquid/firework_blue.xml", pos_x, pos_y, vel_x, vel_y)
	
	elseif (value == 2) then 
		shoot_projectile(player, "mods/Hydroxide/files/Chemical Curiosities/materials/glitteringLiquid/firework_green.xml", pos_x, pos_y, vel_x, vel_y)
	
	elseif (value == 3) then
		shoot_projectile(player, "mods/Hydroxide/files/Chemical Curiosities/materials/glitteringLiquid/firework_orange.xml", pos_x, pos_y, vel_x, vel_y)
	
	elseif (value == 4) then
		shoot_projectile(player, "mods/Hydroxide/files/Chemical Curiosities/materials/glitteringLiquid/firework_pink.xml", pos_x, pos_y, vel_x, vel_y)
	
	end
end
EntityKill(GetUpdatedEntityID())