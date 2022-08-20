local entity_id = GetUpdatedEntityID()

local owner = EntityGetRootEntity(entity_id)

local x,y = EntityGetTransform(owner)

EntityAddChild( owner, EntityLoad("mods/Hydroxide/files/entities/effects/vomit.xml", x,y ))