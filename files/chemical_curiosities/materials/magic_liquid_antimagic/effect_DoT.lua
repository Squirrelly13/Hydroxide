dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity( entity_id )

local gdc = EntityGetFirstComponentIncludingDisabled(root, "GenomeDataComponent") 
if gdc ~= nil then
	local herd = HerdIdToString(ComponentGetValue2(gdc, "herd_id"))
	if (herd == "mage") or (herd == "flower") or (herd == "fungus") or (herd == "mage_swapper") then
		local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )

		local max_hp = ComponentGetValue2( damagemodel, "max_hp" ) 
		EntityInflictDamage( root, max_hp * 0.2, "DAMAGE_POISON", "Mana Deficiency", "NORMAL", 0, 0)
		
	end	
end	