dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/Hydroxide/lib/squirreltilities.lua")




local entity = GetUpdatedEntityID()

local root = EntityGetParent( entity)

if(root == entity)then return end




function ApplyMaterialDamager(target, newMaterial, template)
    if(EntityGetDamageFromMaterial(target, newMaterial) ~= nil) then EntityKill(GetUpdatedEntityID()) end

    local acidstrength = 0.000
    
    local acidstrength = EntityGetDamageFromMaterial(target, template)
    if (acidstrength ~= nil) then
        EntitySetDamageFromMaterial(target, newMaterial, acidstrength)
        GamePrint("Material ".. tostring(newMaterial) .. " now dealing " .. tostring(acidstrength) .. " damage to " .. EntityGetName(target) .. ", mimicking " .. template)
    end  
end


ApplyMaterialDamager(root, "cc_hydroxide", "acid")
ApplyMaterialDamager(root, "aa_divine_magma", "lava")







--[[ if(EntityGetDamageFromMaterial(root, "cc_hydroxide") ~= nil) then EntityKill(GetUpdatedEntityID()) end

local acidstrength = 0.000

local acidstrength = EntityGetDamageFromMaterial(root, "acid")
if (acidstrength ~= nil) then
    EntitySetDamageFromMaterial(root, "cc_hydroxide", acidstrength)
    GamePrint("Hydroxide: " .. tostring(acidstrength))
end ]]-- ^^^^^^^ genius squirrelly code im altering for more general purposes
-- this concept of using a material to secretly change data on an entity could also possibly be used for other stuff, ill keep this idea in mind

