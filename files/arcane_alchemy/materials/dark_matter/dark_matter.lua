local entity = GetUpdatedEntityID()

local root = EntityGetRootEntity( entity )

local x, y = EntityGetTransform(root)

local child_id = EntityLoad( "mods/Hydroxide/files/arcane_alchemy/materials/dark_matter/collapse.xml", x, y )
EntityAddChild( root, child_id )