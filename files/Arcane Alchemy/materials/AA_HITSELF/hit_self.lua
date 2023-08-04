dofile_once("data/scripts/lib/utilities.lua")

local entity = GetUpdatedEntityID()

local root = EntityGetRootEntity( entity )

local x, y = EntityGetTransform(root)

child_id = EntityLoad( "mods/Hydroxide/files/Arcane Alchemy/materials/AA_HITSELF/punch_limb.xml", x, y )
EntityAddChild( root, child_id )
