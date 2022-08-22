dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")


local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )



local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )

local target = EntityGetClosestWithTag(  pos_x, pos_y, "enemy" )
local tpos_x, tpos_y = EntityGetTransform(target)

local angle = 2.5708

if tpos_x ~= nil then
angle = math.atan2( pos_y - tpos_y, tpos_x - pos_x)
end 

local spread = math.rad(Random(-10,10))
angle = angle + spread

local length = Random(600,1500)

local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length
	

shoot_projectile(player, "mods/Hydroxide/files/entities/projectiles/sparkling_particle.xml", pos_x, pos_y, vel_x, vel_y)



EntityKill(GetUpdatedEntityID())