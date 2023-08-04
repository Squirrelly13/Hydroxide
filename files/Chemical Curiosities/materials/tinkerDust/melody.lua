dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

local entity_id = GetUpdatedEntityID()
entity_id = EntityGetRootEntity( entity_id )

local pos_x, pos_y = EntityGetTransform( entity_id )

SetRandomSeed( GameGetFrameNum() + GetUpdatedComponentID(), pos_x + pos_y + entity_id )


local angle = math.rad(Random(70,110))
local length = Random(5,15)

local vel_x = math.cos( angle ) * length
local vel_y = 0 - math.sin( angle ) * length

local value = Random(1,8)

if (value == 1) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_a.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 2 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_c.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 3 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_c.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 4 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_e.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 5 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_e.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 6 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_gsharp.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 7 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_gsharp.xml", pos_x, pos_y, vel_x, vel_y)

elseif (value == 8 ) then
shoot_projectile(player, "data/entities/projectiles/deck/ocarina/ocarina_a2.xml", pos_x, pos_y, vel_x, vel_y)

end
