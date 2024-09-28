local entity_id = GetUpdatedEntityID()

local owner = EntityGetRootEntity(entity_id)

local x,y = EntityGetTransform(owner)

EntityAddChild( owner, EntityLoad("mods/hydroxide/files/lib/vomit/vomit.xml", x,y ))