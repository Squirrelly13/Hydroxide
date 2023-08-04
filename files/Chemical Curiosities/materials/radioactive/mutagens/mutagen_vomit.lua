local entity_id = GetUpdatedEntityID()

local owner = EntityGetRootEntity(entity_id)

local x,y = EntityGetTransform(owner)

EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/scripts/vomit/vomit.xml", x,y ))