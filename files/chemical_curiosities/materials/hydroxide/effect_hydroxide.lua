dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/lib/squirreltilities.lua")




local entity = GetUpdatedEntityID()

local root = EntityGetParent( entity)

if(root == entity)then return end

if(EntityGetDamageFromMaterial(root, "CC_hydroxide") ~= nil) then EntityKill(GetUpdatedEntityID()) end

local acidstrength = 0.000

acidstrength = EntityGetDamageFromMaterial(root, "acid")
if (acidstrength ~= nil) then
EntitySetDamageFromMaterial(root, "CC_hydroxide", acidstrength)
end