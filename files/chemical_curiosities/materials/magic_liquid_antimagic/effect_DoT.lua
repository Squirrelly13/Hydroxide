local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity( entity_id )

local gdc = EntityGetFirstComponentIncludingDisabled(root, "GenomeDataComponent")
if gdc ~= nil then
	local herd = HerdIdToString(ComponentGetValue2(gdc, "herd_id"))
	if (herd == "mage") or (herd == "flower") or (herd == "fungus") or (herd == "mage_swapper") then
		local damagemodel = EntityGetFirstComponentIncludingDisabled( root, "DamageModelComponent" )
		if not damagemodel then return end
		local max_hp = ComponentGetValue2( damagemodel, "max_hp" )
		EntityInflictDamage( root, max_hp * 0.2, "NONE", "Mana Deficiency", "NORMAL", 0, 0)
	end
end