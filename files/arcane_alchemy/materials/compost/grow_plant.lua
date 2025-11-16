local entity_id    = GetUpdatedEntityID()
local pos_x, pos_y = EntityGetTransform( entity_id )
SetRandomSeed( GameGetFrameNum(), pos_x + pos_y + entity_id )

if(Random(1, 100) > 90)then
    EntityLoad("mods/Hydroxide/files/arcane_alchemy/materials/compost/root_grower.xml", pos_x, pos_y)
end

EntityKill(GetUpdatedEntityID())