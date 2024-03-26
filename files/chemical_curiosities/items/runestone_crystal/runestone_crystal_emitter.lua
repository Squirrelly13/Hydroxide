dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )

EntityLoad( "mods/Hydroxide/files/chemical_curiosities/items/runestone_crystal/runestone_crystal_emitter.xml", x, y )