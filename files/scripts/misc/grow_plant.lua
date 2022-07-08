dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

if(Random(1, 100) > 80)then
    EntityLoad("data/entities/props/root_grower.xml", pos_x, pos_y)
end

EntityKill(GetUpdatedEntityID())