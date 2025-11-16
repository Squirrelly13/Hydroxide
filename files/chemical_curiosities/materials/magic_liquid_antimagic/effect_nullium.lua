local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity( entity_id )

local children = EntityGetAllChildren(root) or {}
for i, child in ipairs(children) do
    if EntityGetName( child ) == "inventory_quick" then
        local inventory_items = EntityGetAllChildren(child)
		if(inventory_items ~= nil) then
        for _, item in ipairs(inventory_items) do
            if EntityHasTag( item, "wand" ) then
                local ac_id = EntityGetFirstComponentIncludingDisabled( item, "AbilityComponent" )
                if not ac_id then return end
                local mana = ComponentGetValue2( ac_id, "mana" )
                local mana_charge_speed = ComponentGetValue2( ac_id, "mana_charge_speed" )
                ComponentSetValue2( ac_id, "mana", math.max( mana - (mana_charge_speed / 45), 0 ) )
            end
        end
		end
        break
    end
end

AllergicToNullium = {
    mage = true,
    flower = true,
    fungus = true,
    mage_swapper = true,
}

local gdc = EntityGetFirstComponentIncludingDisabled(root, "GenomeDataComponent")
if gdc ~= nil then
	local herd = HerdIdToString(ComponentGetValue2(gdc, "herd_id"))
	if AllergicToNullium[herd] then

		--[[



			MAKE IT INFLICT DoT


		]]--

		EntitySetDamageFromMaterial(root, "cc_nullium", 0.004)
	end
end	