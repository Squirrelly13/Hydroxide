dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

EntityLoad( "mods/Hydroxide/files/arcane_alchemy/items/runestone_terror/runestone_terror_emitter.xml", x, y )