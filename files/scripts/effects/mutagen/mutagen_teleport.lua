local entity_id = GetUpdatedEntityID()

local owner = EntityGetRootEntity(entity_id)

local x,y = EntityGetTransform(owner)

SetRandomSeed( GameGetFrameNum(), GameGetFrameNum() - 523 )

EntitySetTransform(owner, x+Random(-0.6,0.6), y)