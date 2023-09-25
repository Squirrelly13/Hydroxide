dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local root = EntityGetRootEntity( entity_id )

local children = EntityGetAllChildren(root)
for i, child in ipairs(children) do
    if EntityGetName( child ) == "inventory_quick" then
        local inventory_items = EntityGetAllChildren(child)
		if(inventory_items ~= nil) then
        for i, item in ipairs(inventory_items) do
            if EntityHasTag( item, "wand" ) then
                local ac_id = EntityGetFirstComponentIncludingDisabled( item, "AbilityComponent" )  
                local mana = ComponentGetValue2( ac_id, "mana" ) 
                local mana_charge_speed = ComponentGetValue2( ac_id, "mana_charge_speed" )
                ComponentSetValue2( ac_id, "mana", math.max( mana - (mana_charge_speed / 45), 0 ) )
            end
        end
		end
        break
    end
end

local gdc = EntityGetFirstComponentIncludingDisabled(root, "GenomeDataComponent") 
if gdc ~= nil then
	local herd = HerdIdToString(ComponentGetValue2(gdc, "herd_id"))
	if (herd == "mage") or (herd == "flower") or (herd == "fungus") or (herd == "mage_swapper") then
		
		--[[
		
		
		
			MAKE IT INFLICT DoT
			
			
		]]--

		EntitySetDamageFromMaterial(root, "antimagic", 0.004)
	end	
end	