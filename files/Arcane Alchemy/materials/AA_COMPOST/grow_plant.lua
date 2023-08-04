dofile_once("data/scripts/lib/utilities.lua")

local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y, rot = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

if(Random(1, 100) > 90)then
    EntityLoad("mods/Hydroxide/files/Arcane Alchemy/materials/AA_COMPOST/root_grower.xml", pos_x, pos_y)
end

EntityKill(GetUpdatedEntityID())