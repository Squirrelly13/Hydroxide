dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )

EntityLoad( "data/entities/projectiles/explosion.xml", pos_x, pos_y )


EntityKill( entity_id )